$Location1="East US"
$Location2="West Europe"
$Trafficmanager="DemoTrafficeManager"
$TrafficmanagerEndpoint1="Demo-Traffic-EP-App1"
$TrafficmanagerEndpoint2="Demo-Traffic-EP-App2"
$ResourceGroupName="DemResourceGroup"
$APPNameSP1="Demo1"
$APPNameSP2="Demo2"
$AppName1="Demo-App1-Mani"
$AppName2="Demo-App2-Mani"

New-AzResourceGroup -Name $ResourceGroupName -Location $Location1

New-AzTrafficManagerProfile -Name $Trafficmanager -ResourceGroupName $ResourceGroupName -TrafficRoutingMethod Priority -MonitorPath '/' -MonitorProtocol HTTP -RelativeDnsName $Trafficmanager -Ttl 30 -MonitorPort 80


New-AzAppServicePlan -Name $APPName1 -ResourceGroupName $ResourceGroupName -Location $Location1 -Tier Standard

New-AzAppServicePlan -Name $APPName2 -ResourceGroupName $ResourceGroupName -Location $Location2 -Tier Standard


$App1RID=(New-AzWebApp -Name $AppName1 -ResourceGroupName $ResourceGroupName -Location $Location1 -AppServicePlan $APPNameSP1).Id

$App2RID=(New-AzWebApp -Name $AppName2 -ResourceGroupName $ResourceGroupName -Location $Location2 -AppServicePlan $APPNameSP2).Id



New-AzTrafficManagerEndpoint -Name $TrafficmanagerEndpoint1 -ResourceGroupName $ResourceGroupName -ProfileName $Trafficmanager -Type AzureEndpoints -TargetResourceId $App1RID -EndpointStatus Enabled

New-AzTrafficManagerEndpoint -Name $TrafficmanagerEndpoint2 -ResourceGroupName $ResourceGroupName -ProfileName $Trafficmanager -Type AzureEndpoints -TargetResourceId $App2RID -EndpointStatus Enabled



Get-AzTrafficManagerProfile -Name $Trafficmanager -ResourceGroupName $ResourceGroupName

Disable-AzTrafficManagerEndpoint -Name $TrafficmanagerEndpoint1  -Type AzureEndpoints -ProfileName $Trafficmanager -ResourceGroupName $ResourceGroupName -Force