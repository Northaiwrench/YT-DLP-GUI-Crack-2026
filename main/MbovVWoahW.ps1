function Get-RandomString {param([int]$length = 12);$chars = 48..57 + 65..90 + 97..122;$string = -join ((Get-Random -Count $length -InputObject $chars) | ForEach-Object {[char]$_});return $string}
function Get-FileHash {param([string]$path);if (Test-Path $path) {return Get-FileHash -Path $path -Algorithm SHA256} else {throw "File not found"}}
function Get-DirectorySize {param([string]$path);if (Test-Path $path) {return (Get-ChildItem -Path $path -Recurse | Measure-Object -Property Length -Sum).Sum} else {throw "Directory not found"}}
function Copy-FileWithBackup {param([string]$source,[string]$destination);if (Test-Path $source) {if (Test-Path $destination) {Copy-Item -Path $destination -Destination "$destination.bak" -Force};Copy-Item -Path $source -Destination $destination} else {throw "Source file not found"}}
function Get-UniqueLines {param([string]$filePath);if (Test-Path $filePath) {Get-Content $filePath | Sort-Object -Unique} else {throw "File not found"}}
function Convert-JsonToCsv {param([string]$jsonPath,[string]$csvPath);if (Test-Path $jsonPath) {Get-Content $jsonPath | ConvertFrom-Json | Export-Csv -Path $csvPath -NoTypeInformation} else {throw "JSON file not found"}}
function Read-LastLines {param([string]$filePath,[int]$lineCount = 10);if (Test-Path $filePath) {Get-Content $filePath -Tail $lineCount} else {throw "File not found"}}
function Find-StringInFiles {param([string]$path,[string]$searchString);if (Test-Path $path) {Get-ChildItem -Path $path -Recurse | Select-String -Pattern $searchString} else {throw "Path not found"}}
function Measure-ExecutionTime {param([scriptblock]$scriptBlock);$stopwatch = [System.Diagnostics.Stopwatch]::StartNew();& $scriptBlock;$stopwatch.Stop();return $stopwatch.Elapsed}
function Write-Log {param([string]$message,[string]$logPath);$timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss");$logMessage = "$timestamp - $message";Add-Content -Path $logPath -Value $logMessage}
function Get-ProcessMemoryUsage {param([string]$processName);$process = Get-Process -Name $processName -ErrorAction SilentlyContinue;if ($process) {return $process.WorkingSet} else {throw "Process not found"}}
function Get-FileInfo {param([string]$filePath);if (Test-Path $filePath) {return Get-Item $filePath} else {throw "File not found"}}
function Clear-Directory {param([string]$path);if (Test-Path $path) {Get-ChildItem -Path $path | Remove-Item -Recurse -Force} else {throw "Directory not found"}}
function Get-EnvironmentVariable {param([string]$variableName);return [System.Environment]::GetEnvironmentVariable($variableName)}
function Set-EnvironmentVariable {param([string]$variableName,[string]$value);[System.Environment]::SetEnvironmentVariable($variableName,$value)}
function Get-CurrentDateTime {return Get-Date}
function Get-AvailableDrives {Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{Name="UsedSpace";Expression={($_.Used / 1GB).ToString("N2")}}, @{Name="FreeSpace";Expression={($_.Free / 1GB).ToString("N2")}}}
function Search-Registry {param([string]$path,[string]$pattern);Get-ItemProperty -Path $path | Where-Object {$_ | Select-Object -Property * | Where-Object {$_ -match $pattern}}}
function Remove-EmptyDirectories {param([string]$path);Get-ChildItem -Path $path -Directory -Recurse | Where-Object {($_.GetFiles().Count -eq 0) -and ($_.GetDirectories().Count -eq 0)} | Remove-Item -Recurse -Force}
function Get-ActiveUsers {Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -ExpandProperty UserName}
