$sqlServer='hqdbsp18'
$params = @{'server'='HQDBT01';'Database'='SQLShackDemo'}
 
Function writeDiskInfo {
param($server,$devId,$volName,$frSpace,$totSpace)
$InsertResults = "INSERT INTO [SQLShackDemo].[dbo].[tbl_PosHdisk](SystemName,DeviceID,VolumeName,TotalSize,FreeSize) VALUES ('$SERVER','$devId','$volName',$totSpace,$usedSpace)"      
         Invoke-sqlcmd @params -Query $InsertResults
}
 
$dp = Get-WmiObject win32_logicaldisk -ComputerName $sqlServer|  Where-Object {$_.drivetype -eq 3}
 
foreach ($item in $dp) {
writeDiskInfo $sqlServer $item.DeviceID $item.VolumeName $item.FreeSpace $item.Size
}
