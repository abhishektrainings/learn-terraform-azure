# Migrate Terraform state from Terraform Cloud to Azure Storage
# Reads credentials from environment variables:
# TF_API_TOKEN, TF_ORG, TF_WS, AZ_STORAGE_ACCOUNT, AZ_CONTAINER, AZ_BLOB_NAME, AZ_STORAGE_KEY

if (-not $env:TF_API_TOKEN) { Write-Error 'Missing TF_API_TOKEN'; exit 1 }
if (-not $env:TF_ORG) { Write-Error 'Missing TF_ORG'; exit 1 }
if (-not $env:TF_WS) { Write-Error 'Missing TF_WS'; exit 1 }
if (-not $env:AZ_STORAGE_ACCOUNT) { Write-Error 'Missing AZ_STORAGE_ACCOUNT'; exit 1 }
if (-not $env:AZ_CONTAINER) { Write-Error 'Missing AZ_CONTAINER'; exit 1 }
if (-not $env:AZ_BLOB_NAME) { Write-Error 'Missing AZ_BLOB_NAME'; exit 1 }
if (-not $env:AZ_STORAGE_KEY) { Write-Error 'Missing AZ_STORAGE_KEY'; exit 1 }

$headers = @{ Authorization = "Bearer $($env:TF_API_TOKEN)"; Accept = 'application/vnd.api+json' }
Write-Output "Fetching workspace info for $($env:TF_ORG)/$($env:TF_WS)"
try {
    $wsResp = Invoke-RestMethod -Uri "https://app.terraform.io/api/v2/organizations/$($env:TF_ORG)/workspaces/$($env:TF_WS)" -Headers $headers -Method Get -ErrorAction Stop
} catch {
    Write-Error "Failed to fetch workspace: $_"
    exit 1
}
$ws_id = $wsResp.data.id
Write-Output "Workspace ID: $ws_id"

Write-Output "Fetching current state version..."
try {
    $stateResp = Invoke-RestMethod -Uri "https://app.terraform.io/api/v2/workspaces/$ws_id/current-state-version" -Headers $headers -Method Get -ErrorAction Stop
} catch {
    Write-Error "Failed to fetch current state version: $_"
    exit 1
}
$download_url = $stateResp.data.attributes.'hosted-state-download-url'
if (-not $download_url) { Write-Error 'No hosted-state-download-url found'; exit 1 }
Write-Output "Downloading state from Terraform Cloud..."
try {
    Invoke-WebRequest -Uri $download_url -OutFile "terraform.tfstate" -Headers $headers -UseBasicParsing -ErrorAction Stop
} catch {
    Write-Error "Failed to download state file: $_"
    exit 1
}
Write-Output "Downloaded terraform.tfstate (size: $(Get-Item terraform.tfstate).Length bytes)"

Write-Output "Creating container '$($env:AZ_CONTAINER)' in storage account '$($env:AZ_STORAGE_ACCOUNT)' (if missing)"
$createArgs = @(
    'storage','container','create',
    '--name',$env:AZ_CONTAINER,
    '--account-name',$env:AZ_STORAGE_ACCOUNT,
    '--account-key',$env:AZ_STORAGE_KEY
)
$rc = & az @createArgs
if ($LASTEXITCODE -ne 0) { Write-Error 'az storage container create failed'; exit 1 }

Write-Output "Uploading blob $($env:AZ_BLOB_NAME)..."
$uploadArgs = @(
    'storage','blob','upload',
    '--account-name',$env:AZ_STORAGE_ACCOUNT,
    '--container-name',$env:AZ_CONTAINER,
    '--name',$env:AZ_BLOB_NAME,
    '--file','terraform.tfstate',
    '--account-key',$env:AZ_STORAGE_KEY,
    '--overwrite'
)
$rc = & az @uploadArgs
if ($LASTEXITCODE -ne 0) { Write-Error 'az storage blob upload failed'; exit 1 }

Write-Output "Upload complete. Running 'terraform init -reconfigure'"
$env:ARM_SKIP_PROVIDER_REGISTRATION = 'true'
terraform init -reconfigure
if ($LASTEXITCODE -ne 0) { Write-Error 'terraform init -reconfigure failed'; exit 1 }

Write-Output "Running 'terraform validate'"
terraform validate
Write-Output "Running 'terraform plan'"
terraform plan -refresh=true

Write-Output 'Migration script completed.'
