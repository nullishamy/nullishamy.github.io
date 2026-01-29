#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "moving on-prem users to Entra",
    date: "2025-09-05",
    author: "amy erskine",
    summary: [how to migrate your Active Directory users],
    tags: ("tidbits", "microsoft"),
)

#show: post.with(..args)

If you're an organisation with a Hybrid identity setup, you may eventually want to move some of those on-prem users into cloud-only accounts. Such users might be legacy shared mailbox accounts, external contractors, or just accounts kept for archival.

Pro tip: Shared mailboxes don't need a 365 license (if their archives are < 50GB), use this trick to save on licenses.

When moving users, there's a few pitfalls and cleanup tasks to be run to stop #link("https://learn.microsoft.com/en-us/entra/identity/hybrid/connect/whatis-azure-ad-connect")[Entra Connect] from erroring out.

To start, assign all of the targetted accounts with a license. This won't be permanent but you should have licenses spare to avoid losing archives. 
From what I understand the archives _should_ be kept for up to 30 days even if they are outside of license limits, but I always assign licenses to be safe.

I'm assigning Office E3, your SKU number might differ.
```powershell
param($UserId)

Connect-MgGraph -Scopes User.ReadWrite.All, Organization.Read.All

$officee3 = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq 'ENTERPRISEPACK'
Set-MgUserLicense -UserId $UserId -AddLicenses @{ SkuId = $officee3.SkuId } -RemoveLicenses @()
```

Next, stop your on-premise users from syncing. This will "delete" them, which is intentional. I use a specific OU which is excluded from Entra Connect for this purpose. Run a sync or wait for the sync to complete.

Now the mailboxes should have disappeared from Entra/Exchange. You can go to the main admin center > Users > Deleted Users to restore them.

We now need to clean up the #link("https://learn.microsoft.com/en-us/dotnet/api/microsoft.azure.powershell.cmdlets.resources.msgraph.models.apiv10.microsoftgraphuser.onpremisesimmutableid?view=az-ps-latest")[`onPremisesImmutableId` property]:
```powershell
Connect-MgGraph -Scopes User.ReadWrite -NoWelcome

$upn = "<user UPN>"

$user = Get-MgUser -UserId $upn -Property OnPremisesImmutableId, Id | Select-Object Id, OnPremisesImmutableId

Write-Output $user

$userId = $user.Id
$body = @{
    onPremisesImmutableId = $null
}

Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/users/$userId" -Body $body
```

This will **break** the on-premise link. Be sure you're operating on the right accounts.

Wait for the Exchange mailboxes to get assigned, then verify they are all set to SharedMailbox mode:
```powershell
$upnList | ForEach-Object { Get-Mailbox $_ } | fl PrimarySmtpAddress, RecipientTypeDetails
```

That's it, you can now clean up the licenses and disable the accounts (if relevant):
```powershell
$params = @{
    accountEnabled = $false
}

$upnList | ForEach-Object { 
    $archiveStats = Get-ExoMailboxStatistics -Archive $_ -ErrorAction SilentlyContinue
    if (($null -ne $archiveStats) -and ($archiveStats.TotalItemSize.Value.ToBytes() -gt 40GB)) {
        Write-Error "User $_ has mailbox too large to stay unlicensed"
        exit 1
    }

    if ($null -eq $archiveStats) {
        Write-Error "Couldn't find archive for mailbox $UserId"
        exit 1
    }

    # Remove our E3 license and Business Premium if applied
    $license = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq 'ENTERPRISEPACK'
    Set-MgUserLicense -UserId $_ -AddLicenses @() -RemoveLicenses @($license.SkuId)  -ErrorAction SilentlyContinue
    $license = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq 'SPB' 
    Set-MgUserLicense -UserId $_ -AddLicenses @() -RemoveLicenses @($license.SkuId) -ErrorAction SilentlyContinue

    Write-Host "Removed licenses for $_"


    Update-MgUser -UserId $_ -BodyParameter $params
}
```
