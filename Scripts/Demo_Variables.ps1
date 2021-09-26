echo "Script is running"
echo $env:Resource_Group_Name
echo $Env:BUILD_SOURCESDIRECTORY
echo $Echo:SourceBranch

if(test-path $Env:BUILD_SOURCESDIRECTORY\Settings\Demo_Variables.json){
    $JsonFilePath = "$Env:BUILD_SOURCESDIRECTORY\Settings\Demo_Variables.json"
    $Jsonvariable = Get-Content $($JsonFilePath) | out-string | ConvertFrom-Json
    echo $Jsonvariable
    echo $Jsonvariable.Resource_GroupName_from_JSON
}
else{
    echo "file doesnt exist"
}

<#
if(test-path $Env:SourceBranch\Settings\Demo_Variables.json){
 echo "file exist"
}
else{
    echo "file doesnt exist"
}

#>

#echo " this is from line 3" $env:Demo_Variables.Resource_Group_Name

<#
$JsonFilePath = $Env:BUILD_SOURCESDIRECTORY\Settings\Demo_Variables.json
$Jsonvariable = Get-Content $($JsonFilePath) | out-string | ConvertFrom-Json
echo $Jsonvariable


$JsonFilePath = $Env:BUILD_SOURCESDIRECTORY\Settings\Demo_Variables.json
$Jsonvariable = Get-Content $($JsonFilePath) | out-string | ConvertFrom-Json
echo $Jsonvariable

#>