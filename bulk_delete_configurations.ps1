$api_key = "Enter your API Key here"
$count = 0
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/vnd.api+json")
$headers.Add("x-api-key", $api_key)
$PatchUrl = "https://api.itglue.com/configurations?page[size]=1000"

$response = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

$totalpage = $response.meta.'total-pages'

for($i=1; $i -le $totalpage; $i++){

$responseGet = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

$asset_id_list = $responseGet.data.id

<#Delet Configurations#>

foreach($id in $asset_id_list)
{
Write-Host "Configuration_id: "$id

$body = @"
{
    `"data`":
         {          
             `"type`": `"configurations`",
             `"attributes`": {
                `"id`":`"$id`"
             }
         }
 }

"@
$PatchUrldelete = 'https://api.itglue.com/configurations/'
$responsedelete = Invoke-RestMethod $PatchUrldelete -Method 'DELETE' -Headers $headers -Body $body

$count++
Write-Host "Count of item deleted successfully: "$count
}
}
