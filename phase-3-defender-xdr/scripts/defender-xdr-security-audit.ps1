# =============================================================
#  defender-xdr-security-audit.ps1
#  Phase 3 — Microsoft Defender XDR Security Audit
#  Meridian Institute M365 Security Lab
#  Author: Md Rahat Islam Anik
#  Description: Audits Microsoft Defender XDR security posture
#  including Secure Score, risky users, security alerts,
#  identity protection signals, and security recommendations
#  across the Meridian Institute M365 tenant.
# =============================================================

Connect-MgGraph -Scopes "SecurityEvents.Read.All","SecurityActions.Read.All","IdentityRiskyUser.Read.All","Policy.Read.All","AuditLog.Read.All","Directory.Read.All" -NoWelcome

$Date = Get-Date -Format "yyyy-MM-dd"
$ReportPath = "$HOME/Documents/Meridian-Institute-M365-Lab/phase-3-defender-xdr/reports"

# ── 1. Secure Score ──────────────────────────────────────────
Write-Host "`n📋 Fetching Secure Score..." -ForegroundColor Cyan
$SecureScores = Get-MgSecuritySecureScore -Top 1
$LatestScore = $SecureScores | Select-Object -First 1

if ($LatestScore) {
    $CurrentScore = [math]::Round($LatestScore.CurrentScore, 2)
    $MaxScore = [math]::Round($LatestScore.MaxScore, 2)
    $Percentage = [math]::Round(($CurrentScore / $MaxScore) * 100, 1)
    Write-Host "   Current Secure Score: $CurrentScore / $MaxScore ($Percentage%)" -ForegroundColor Green
} else {
    Write-Host "   No Secure Score data available" -ForegroundColor Yellow
    $CurrentScore = 0; $MaxScore = 0; $Percentage = 0
}

# ── 2. Secure Score Control Profiles ─────────────────────────
Write-Host "`n📋 Fetching Secure Score control profiles..." -ForegroundColor Cyan
$Controls = Get-MgSecuritySecureScoreControlProfile -All
Write-Host "   Total controls available: $($Controls.Count)" -ForegroundColor Green

$ControlReport = foreach ($Control in $Controls) {
    [PSCustomObject]@{
        Title           = $Control.Title
        Category        = $Control.ControlCategory
        ActionType      = $Control.ActionType
        Service         = $Control.Service
        MaxScore        = $Control.MaxScore
        Tier            = $Control.Tier
        UserImpact      = $Control.UserImpact
        ImplementationCost = $Control.ImplementationCost
        Threats         = ($Control.Threats -join "; ")
    }
}

# ── 3. Risky Users ───────────────────────────────────────────
Write-Host "`n📋 Fetching risky users..." -ForegroundColor Cyan
try {
    $RiskyUsers = Get-MgRiskyUser -All
    Write-Host "   Risky users detected: $($RiskyUsers.Count)" -ForegroundColor $(if ($RiskyUsers.Count -gt 0) { "Red" } else { "Green" })

    $RiskyUserReport = foreach ($User in $RiskyUsers) {
        [PSCustomObject]@{
            DisplayName      = $User.UserDisplayName
            UPN              = $User.UserPrincipalName
            RiskLevel        = $User.RiskLevel
            RiskState        = $User.RiskState
            RiskDetail       = $User.RiskDetail
            RiskLastUpdated  = $User.RiskLastUpdatedDateTime
        }
    }
} catch {
    Write-Host "   Unable to fetch risky users — P2 license may be required" -ForegroundColor Yellow
    $RiskyUsers = @()
    $RiskyUserReport = @()
}

# ── 4. Security Alerts ───────────────────────────────────────
Write-Host "`n📋 Fetching security alerts..." -ForegroundColor Cyan
try {
    $Alerts = Get-MgSecurityAlert -All
    Write-Host "   Security alerts found: $($Alerts.Count)" -ForegroundColor $(if ($Alerts.Count -gt 0) { "Yellow" } else { "Green" })

    $AlertReport = foreach ($Alert in $Alerts) {
        [PSCustomObject]@{
            Title       = $Alert.Title
            Severity    = $Alert.Severity
            Status      = $Alert.Status
            Category    = $Alert.Category
            CreatedDate = $Alert.CreatedDateTime
            Provider    = $Alert.VendorInformation.Provider
        }
    }
} catch {
    Write-Host "   Unable to fetch alerts" -ForegroundColor Yellow
    $Alerts = @()
    $AlertReport = @()
}

# ── 5. Sign-in Audit Log Summary ─────────────────────────────
Write-Host "`n📋 Fetching recent sign-in activity..." -ForegroundColor Cyan
try {
    $SignIns = Get-MgAuditLogSignIn -Top 50 -Filter "createdDateTime ge $((Get-Date).AddDays(-7).ToString('yyyy-MM-ddTHH:mm:ssZ'))"
    $FailedSignIns = $SignIns | Where-Object { $_.Status.ErrorCode -ne 0 }
    $SuccessSignIns = $SignIns | Where-Object { $_.Status.ErrorCode -eq 0 }
    Write-Host "   Sign-ins (last 7 days): $($SignIns.Count) total — $($SuccessSignIns.Count) success, $($FailedSignIns.Count) failed" -ForegroundColor Green
} catch {
    Write-Host "   Unable to fetch sign-in logs" -ForegroundColor Yellow
    $SignIns = @(); $FailedSignIns = @(); $SuccessSignIns = @()
}

# ── 6. Summary Display ──────────────────────────────────────
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  MERIDIAN INSTITUTE — DEFENDER XDR AUDIT SUMMARY" -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "  Secure Score          : $CurrentScore / $MaxScore ($Percentage%)"
Write-Host "  Total Security Controls: $($Controls.Count)"
Write-Host "  Risky Users           : $($RiskyUsers.Count)" -ForegroundColor $(if ($RiskyUsers.Count -gt 0) { "Red" } else { "Green" })
Write-Host "  Security Alerts       : $($Alerts.Count)" -ForegroundColor $(if ($Alerts.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host "  Sign-ins (7 days)     : $($SignIns.Count)"
Write-Host "  Failed Sign-ins       : $($FailedSignIns.Count)" -ForegroundColor $(if ($FailedSignIns.Count -gt 0) { "Yellow" } else { "Green" })
Write-Host ""

# ── 7. Export CSV Reports ────────────────────────────────────
$ControlReport   | Export-Csv "$ReportPath/secure-score-controls-$Date.csv" -NoTypeInformation
$RiskyUserReport | Export-Csv "$ReportPath/risky-users-$Date.csv" -NoTypeInformation
$AlertReport     | Export-Csv "$ReportPath/security-alerts-$Date.csv" -NoTypeInformation

Write-Host "✅ Reports saved to: $ReportPath" -ForegroundColor Green
Write-Host "`nDone!`n" -ForegroundColor Cyan
