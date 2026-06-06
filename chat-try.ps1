$apiKey = "replace"
$apiUrl = "http://localhost:4000/v1/chat/completions"
$body = @{
    model       = "llama3-local"
    messages    = @(
        @{
            role    = "user"
            content = "que es docker y como funciona"
        }
    )
    temperature = 0.7
    max_tokens  = 500
} | ConvertTo-Json -Depth 10

$headers = @{
    Authorization = "Bearer $apiKey"
}

$response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -ContentType "application/json; charset=utf-8" -Body $body
Write-Output $response