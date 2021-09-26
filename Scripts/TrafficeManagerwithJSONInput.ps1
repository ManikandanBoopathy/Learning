#Install-Module -Name Az -Scope CurrentUser -Force -ErrorAction SilentlyContinue -Verbose.

if(test-path $Env:BUILD_SOURCESDIRECTORY\Settings\TrafficManagerSettings.json){
    $JsonFilePath = "$Env:BUILD_SOURCESDIRECTORY\Settings\TrafficManagerSettings.json"
    $Jsonvariable = Get-Content $($JsonFilePath) | out-string | ConvertFrom-Json
    echo $Jsonvariable
}


New-AzResourceGroup -Name $Jsonvariable.ResourceGroupName -Location $Jsonvariable.Location.Location1

New-AzTrafficManagerProfile -Name $Jsonvariable.TrafficManagerName -ResourceGroupName $Jsonvariable.ResourceGroupName -TrafficRoutingMethod Priority -MonitorPath '/' -MonitorProtocol HTTP -RelativeDnsName $Jsonvariable.TrafficManagerName -Ttl 30 -MonitorPort 80


New-AzAppServicePlan -Name $Jsonvariable.AppNameServicePlans.APPNameSP1 -ResourceGroupName $Jsonvariable.ResourceGroupName -Location $Jsonvariable.Location.Location1 -Tier Standard

New-AzAppServicePlan -Name $Jsonvariable.AppNameServicePlans.APPNameSP2  -ResourceGroupName $Jsonvariable.ResourceGroupName -Location $Jsonvariable.Location.Location2 -Tier Standard


$App1RID=(New-AzWebApp -Name $Jsonvariable.AppNames.AppName1 -ResourceGroupName $Jsonvariable.ResourceGroupName -Location $Jsonvariable.Location.Location1 -AppServicePlan $Jsonvariable.AppNameServicePlans.APPNameSP1).Id

$App2RID=(New-AzWebApp -Name $AppName2 -ResourceGroupName $Jsonvariable.ResourceGroupName -Location $Jsonvariable.Location.Location2 -AppServicePlan $Jsonvariable.AppNameServicePlans.APPNameSP2).Id



New-AzTrafficManagerEndpoint -Name $Jsonvariable.TrafficManagerEndpoints.TrafficmanagerEndpoint1 -ResourceGroupName $Jsonvariable.ResourceGroupName -ProfileName $Jsonvariable.TrafficManagerName -Type AzureEndpoints -TargetResourceId $App1RID -EndpointStatus Enabled

New-AzTrafficManagerEndpoint -Name $Jsonvariable.TrafficManagerEndpoints.TrafficmanagerEndpoint2 -ResourceGroupName $Jsonvariable.ResourceGroupName -ProfileName $Jsonvariable.TrafficManagerName -Type AzureEndpoints -TargetResourceId $App2RID -EndpointStatus Enabled



#Get-AzTrafficManagerProfile -Name $Trafficmanager -ResourceGroupName $ResourceGroupName

#Disable-AzTrafficManagerEndpoint -Name $TrafficmanagerEndpoint1  -Type AzureEndpoints -ProfileName $Trafficmanager -ResourceGroupName $ResourceGroupName -Force