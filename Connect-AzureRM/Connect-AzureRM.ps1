function Connect-AzureRm
{
  if ( !(GCM -Module AzureRM*) ) { Install-Module AzureRM -Force; Install-Module Azure -Force -AllowClobber }
  $currContext = try { Get-AzureRmContext -ErrorAction SilentlyContinue } catch {}
  
  function login {
    Add-AzureRmAccount | Out-Null
    setContext
  }
  
  function setContext {
    $subs = Get-AzureRmSubscription
    $selection = $subs | Select SubscriptionName, SubscriptionId | OGV -Title "This account contains the following subscriptions:" -PassThru
    Select-AzureRmSubscription -SubscriptionId $selection.SubscriptionId
  }
  
  if ( $currContext ) {
    cls
    Write-Host -ForegroundColor Green "`nYou are currenly logged into an AzureRM account, this is your current context:"
    $currContext | Out-String
    $stay = Read-Host "`nDo you want to stay within this context (Y\N)"
  } else {
    login
  }
 

  if ( $stay -eq "n") {
    $stay = Read-Host "`nDo you want to log into a new Azure account\tenant (Y\N)"
    
    if ($stay -eq "n") {
      setContext
    } else {
      login
    }

  } else {
	  $currContext
    Break
  }

}
