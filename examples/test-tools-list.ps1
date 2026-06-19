# Usage: $env:API_KEY = 'xxx'; .\test-tools-list.ps1
param([string]$ApiKey = $env:API_KEY)
if (-not $ApiKey) { $ApiKey = 'YOUR_API_KEY' }
$headers = @{
  Authorization = "Bearer $ApiKey"
  'Content-Type' = 'application/json'
}
$body = '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
Invoke-RestMethod -Uri 'https://mcp.htmlweb.ru/' -Method Post -Headers $headers -Body $body
