# Ensure Power BI module is installed
Import-Module MicrosoftPowerBIMgmt

# Connect to Power BI (if not already connected)
Connect-PowerBIServiceAccount

# Define conflict action
$Conflict = "CreateOrOverwrite"

# Define Capacity ID
$CapacityId = "00000000-0000-0000-0000-000000000000"  # Replace with your capacity ID

# Define workspace details
$WorkspaceName = "AETHER - MyNewWorkspace"

# Define report details
$ReportName = "AETHER - MyReport"

# Define PBIX file path
$DeployPath = "C:\Temp\myreport.pbix"

# Create the workspace
$Workspace = New-PowerBIWorkspace -Name $WorkspaceName

# Wait a few seconds for workspace creation - just incase it needs time to be accessible
Start-Sleep -Seconds 5

# Assign the workspace to a Power BI Premium capacity - Not this will require some additional licence and access considerations to do with commands!
Set-PowerBIWorkspace -Id $Workspace.Id -CapacityId $CapacityId -Scope Organization

# Add a user as an admin
Add-PowerBIWorkspaceUser -Id $Workspace.Id -UserPrincipalName "user@jamesmm.com" -AccessRight Admin

# Publish the Power BI report
New-PowerBIReport -Path $DeployPath -Name $ReportName -WorkspaceId $Workspace.Id -ConflictAction $Conflict
