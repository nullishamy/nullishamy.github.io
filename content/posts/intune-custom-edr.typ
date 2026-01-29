#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "ensure your EDR's state with Intune",
    date: "2025-08-06",
    author: "amy erskine",
    summary: [how to get your EDR as a compliance requirement],
    tags: ("tidbits", "intune"),
)

#show: post.with(..args)

As you delve further into Intune, you may want to experiment with different compliance policies. For example, ensuring your company EDR is installed and active.

Most of the time the builtin "Antivirus" indicator, but in my experience it can be flakey. It also does not check _which_ solution is active, only that _a_ solution is active.

To check for your own EDR, you can write a custom compliance scraper. I found this template and tweaked it to my needs: #link("https://github.com/Jeroen-J-Bakker/Intune/tree/main/CustomCompliance")[Jeroen-J-Bakker/Intune]. This is what I have under "Rules":
```json
{ 
    "SettingName":"AntiVirusProductName",
    "Operator":"IsEquals",
    "DataType":"String",
    "Operand":"Bitdefender Endpoint Security Tools Antimalware",
    "MoreInfoUrl":"https://google.com",
    "RemediationStrings":[ 
        { 
            "Language":"en_US",
            "Title":"Bitdefender is not installed",
            "Description": "Contact IT immediately to have the EDR installed. Detected {ActualValue}"
        }
    ]
},
```
The MoreInfo URL is required but we don't have any docs yet.
"ActualValue" is templated in by Intune, which aids in diagnosis.

I would recommend changing the "Mark device compliant after" to a day or two, rather than immediately, to prevent a massive amount of failures when the check initially runs.

If you have failures, such as the script detecting another EDR, one thing to look at is what Windows has stored in its database. You can use this cmdlet to do that:
```powershell
Get-CimInstance -Namespace "ROOT\SecurityCenter2" -ClassName AntiVirusProduct
```

In my case, we had a detection for an old EDR that was no longer installed or used, but was still present in the database. I wrote an Intune Remediation so that it can fix itself before devices are blocked from 365.
```powershell
# Detect-Webroot.ps1
$products = Get-CimInstance -Namespace 'ROOT\SecurityCenter2' -ClassName AntiVirusProduct
$hasWebroot = ($products | Where-Object { $_.displayName -like "*webroot*" }).Count -ne 0

if ($hasWebroot) {
  exit 1
}

exit 0
```
```powershell
# Remediate-Webroot.ps1
Get-CimInstance -Namespace 'ROOT\SecurityCenter2' -ClassName AntiVirusProduct | Where-Object { $_.displayName -like "*webroot*" } | Remove-CimInstance
```

I would always recommend pairing up compliance policies with remediations, ideally together in Intune, so that users see minimal impact. Having the remediation present in Intune also means you can #link("https://learn.microsoft.com/en-us/intune/intune-service/fundamentals/remediations#run-a-remediation-script-on-demand-preview")[run them on-demand], a handy feature.
