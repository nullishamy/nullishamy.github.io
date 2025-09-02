---
title: stop HCL Notes from taking over
description: managing mail defaults
permalink: posts/{{ title | slugify }}/index.html
date: '2025-09-02'
tags: [windows, ibm]
---
This rabit hole came through a user request to stop HCL Notes (the IBM mail product) from being their default mail application. We moved to Outlook not too long ago but some older devices still have this default set.

Not a problem, I think, I'll just go into the Settings UI and changeover the `mailto` default. Boy was I in for a ride.

As it turns out, the user was not clicking on a mailto link, an eml file, or anything typical. They were using the explorer *context action* to initiate their email.

The "Send to mail recipient" context action comes from the existence of the `mapimail` protocol which can be created by placing a file (with the name `Mail Recipient.MAPIMail`, where "Mail Recipient" is the key in the context menu) in the folder `C:\Users\{user}\AppData\Roaming\Microsoft\Windows\SendTo`

The [MAPI protocol](https://en.wikipedia.org/wiki/MAPI) is what allows programs to be "email aware". The actual calling process for MAPI involves looking for the DLL specified at the registry path `HKLM\SOFTWARE\Clients\Mail\{client}\DLLPath[Ex]`, which will contain the exposed functions required for MAPI

You can control which client is in use by changing the key at `HKLM\SOFTWARE\Clients\Mail\`. This key is shown as `(default)` in regedit, but manipulated by passing an empty string to the PS registry functions. You will also have to change the user overrides, located at `HKU\{SID}\Software\Clients\Mail`, if one is set. 

SIDs are what uniquely identify a user in this context, and you can grab the SID for the current user with this snippet:
```powershell
(New-Object System.Security.Principal.NTAccount($env:UserName))
	.Translate([System.Security.Principal.SecurityIdentifier])
	.Value
```

As you may intuit, a user preference takes priority over the system setting. This means that you must set (or unset) the user option for the change to actually take effect. HCL Notes (at least historic versions) wrote to both, or caused both to be written by Windows' Settings GUI, so both need to be changed in most cases.

HCL Notes can live side-by-side with Outlook, and this change only tells the system to prefer Outlook for MAPI operations. Mailto operations (such as browser email links) must be set in the Windows Setting GUI. Windows places a lot of (effective) barriers in place to stop programs changing these settings, in the name of security / user choice.

With this, I made a script to fetch the defaults:
```powershell
$userClients = Get-ChildItem -Path Registry::HKEY_USERS | 
Where-Object { -not $_.Name.EndsWith("Classes") } | 
ForEach-Object {
  $k = $_.OpenSubKey("Software\Clients\Mail")
  if ($null -ne $k) {
    return [PSCustomObject] @{
      User = $_
      Value = $k.GetValue("")
    }
  } else {
    return $null
  }
}

Write-Output $userClients

Write-Output ([PSCustomObject] @{
  User = "LocalMachine"
  Value = (Get-ItemProperty Registry::HKEY_LOCAL_MACHINE\Software\Clients\Mail)."(default)"
})
```

The script used to write the new defaults was much the same, just removing the output writing and using a setter instead of a getter.

```powershell
Get-ChildItem -Path Registry::HKEY_USERS | 
Where-Object { -not $_.Name.EndsWith("Classes") } | 
ForEach-Object {
  # The second parameter $true allows us to later modify the key
  # it sets the key up to be writeable instead of readonly
  $k = $_.OpenSubKey("Software\Clients\Mail", $true)
  if ($null -ne $k) {
    $k.SetValue("", "Microsoft Outlook")
  }
}

Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Clients\Mail -Name "(default)" -Value "Microsoft Outlook"
```