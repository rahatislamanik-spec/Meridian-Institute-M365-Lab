# =============================================================
#  endpoint-compliance-audit.ps1
#  Phase 5 — Endpoint Compliance & Conditional Access Audit
#  Meridian Institute M365 Security Lab
#  Author: Md Rahat Islam Anik
#  Description: Audits Conditional Access policies, Intune
#  compliance policies, device compliance posture, and
#  endpoint security baseline status across the Meridian
#  Institute Microsoft 365 tenant.
# =============================================================

Connect-MgGraph -Scopes "Policy.Read.All","DeviceManagementConfiguration.Read.All","Directory.Read.All" -NoWelcome

$Date = Get-Date -Format "yyyy-MM-dd"
$ReportPath = "$HOME/Documents/Meridian-Institute-M365-Lab/phase-5-endpoint-compliance/reports"

Write-Host "`n🔒 Phase 5 — Endpoint Compliance & Conditional Access Audit" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray

# ── 1. Conditional Access Policies ───────────────────────────
Write-Host "`n📋 Fetching Conditional Access policies..." -ForegroundColor Cyan
$CAPolicies = Get-MgIdentityConditionalAccessPolicy -All
Write-Host "   Total CA policies: $($CAPolicies.Count)" -ForegroundColor Green

$CAReport = foreach ($Policy in $CAPolicies) {
    [PSCustomObject]@{
        PolicyName       = $Policy.DisplayName
        State            = $Policy.State
        CreatedDateTime  = $Policy.CreatedDateTime
        ModifiedDateTime = $Policy.ModifiedDateTime
        IncludeUsers     = ($Policy.Conditions.Users.IncludeUsers -join "; ")
        IncludeGroups    = ($Policy.Conditions.Users.IncludeGroups -join "; ")
        IncludeApps      = ($Policy.Conditions.Applications.IncludeApplications -join "; ")
        GrantControls    = ($Policy.GrantControls.BuiltInControls -join "; ")
        SessionControls  = if ($Policy.SessionControls) { "Configured" } else { "None" }
    }
}

$EnabledPolicies = $CAPolicies | Where-Object { $_.State -eq "enabled" }
$ReportOnly = $CAPolicies | Where-Object { $_.State -eq "enabledForReportingButNotEnforced" }
$DisabledPolicies = $CAPolicies | Where-Object { $_.State -eq "disabled" }

# ── 2. Intune Compliance Policies ────────────────────────────
Write-Host "`n📋 Fetching Intune compliance policies..." -ForegroundColor Cyan
try {
    $CompliancePolicies = Get-MgDeviceManagementDeviceCompliancePolicy -All
    Write-Host "   Total compliance policies: $($CompliancePolicies.Count)" -ForegroundColor Green

    $ComplianceReport = foreach ($Policy in $CompliancePolicies) {
        [PSCustomObject]@{
            PolicyName    = $Policy.DisplayName
            Platform      = $Policy.AdditionalProperties['@odata.type'] -replace '#microsoft.graph.', ''
            CreatedDate   = $Policy.CreatedDateTime
            ModifiedDate  = $Policy.LastModifiedDateTime
            Description   = $Policy.Description
        }
    }
} catch {
    Write-Host "   Unable to fetch compliance policies — license may be required" -ForegroundColor Yellow
    $CompliancePolicies = @()
    $ComplianceReport = @()
}

# ── 3. Managed Devices ───────────────────────────────────────
Write-Host "`n📋 Fetching managed devices..." -ForegroundColor Cyan
try {
    $Devices = Get-MgDeviceManagementManagedDevice -All
    $CompliantDevices = $Devices | Where-Object { $_.ComplianceState -eq "compliant" }
    $NonCompliantDevices = $Devices | Where-Object { $_.ComplianceState -eq "noncompliant" }
    Write-Host "   Total managed devices: $($Devices.Count)" -ForegroundColor Green
    Write-Host "   Compliant: $($CompliantDevices.Count) | Non-compliant: $($NonCompliantDevices.Count)" -ForegroundColor Green

    $DeviceReport = foreach ($Device in $Devices) {
        [PSCustomObject]@{
            DeviceName      = $Device.DeviceName
            OS              = $Device.OperatingSystem
            OSVersion       = $Device.OsVersion
            ComplianceState = $Device.ComplianceState
            Owner           = $Device.UserDisplayName
            LastSync        = $Device.LastSyncDateTime
            ManagementAgent = $Device.ManagementAgent
        }
    }
} catch {
    Write-Host "   Unable to fetch managed devices" -ForegroundColor Yellow
    $Devices = @()
    $DeviceReport = @()
}

# ── 4. Summary ───────────────────────────────────────────────
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  PHASE 5 — ENDPOINT COMPLIANCE AUDIT SUMMARY" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  Total CA Policies        : $($CAPolicies.Count)"
Write-Host "  Enabled Policies         : $($EnabledPolicies.Count)" -ForegroundColor $(if ($EnabledPolicies.Count -gt 0) { "Green" } else { "Yellow" })
Write-Host "  Report-Only Policies     : $($ReportOnly.Count)" -ForegroundColor Cyan
Write-Host "  Disabled Policies        : $($DisabledPolicies.Count)" -ForegroundColor $(if ($DisabledPolicies.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host "  Intune Compliance Policies: $($CompliancePolicies.Count)"
Write-Host "  Managed Devices          : $($Devices.Count)"
Write-Host "  Compliant Devices        : $($CompliantDevices.Count)" -ForegroundColor Green
Write-Host "  Non-Compliant Devices    : $($NonCompliantDevices.Count)" -ForegroundColor $(if ($NonCompliantDevices.Count -gt 0) { "Red" } else { "Green" })
Write-Host ""

# ── 5. Export Reports ────────────────────────────────────────
$CAReport       | Export-Csv "$ReportPath/conditional-access-policies-$Date.csv" -NoTypeInformation
$ComplianceReport | Export-Csv "$ReportPath/intune-compliance-policies-$Date.csv" -NoTypeInformation
$DeviceReport   | Export-Csv "$ReportPath/managed-devices-$Date.csv" -NoTypeInformation

Write-Host "✅ Reports saved to: $ReportPath" -ForegroundColor Green
Write-Host "`nDone!`n" -ForegroundColor Cyan
