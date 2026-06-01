# Meridian Institute — Microsoft 365 Security Operations Lab

> A multi-phase, fully documented Microsoft 365 enterprise simulation built in a real developer tenant — covering identity governance, endpoint management, compliance controls, Conditional Access, and PowerShell automation across 27 managed users and 4 admin centers.

**Author:** Md Rahat Islam Anik · [linkedin.com/in/rahatislamanik](https://linkedin.com/in/rahatislamanik) · [github.com/rahatislamanik-spec](https://github.com/rahatislamanik-spec)

---

## Live Portfolio Pages

| Phase | Focus | Link |
|---|---|---|
| Phase 1 | Identity, Users, Groups, PowerShell, Sign-In Security | [View Phase 1 →](https://rahatislamanik-spec.github.io/Meridian-Institute-M365-Lab/phase-1/) |
| Phase 2 | Endpoint, Conditional Access, Purview DLP, Exchange | [View Phase 2 →](https://rahatislamanik-spec.github.io/Meridian-Institute-M365-Lab/phase-2/) |

---

## What This Lab Demonstrates

This project simulates the full lifecycle of a Microsoft 365 environment buildout for a mid-size educational institution. Every configuration decision is documented through real admin portal screenshots, PowerShell output, and audit evidence — not tutorials or sandboxes.

The goal: prove hands-on competency across the exact tooling required for IT Support, M365 Administration, and Cloud Security Operations roles.

---

## Phase 1 — Identity & Security Operations Baseline

**Admin Centers Used:** Microsoft 365 Admin Center · Microsoft Entra ID

### What Was Built

**Tenant Provisioning & User Management**
- Bulk-provisioned 27 users across 4 role categories (Students, Professors, IT Operations, Security Operations) with zero manual errors
- Created security groups with dynamic membership rules for automated role-based group assignment
- Identified and flagged 6 unlicensed student accounts using PowerShell Graph API filtering
- Assigned Microsoft 365 licenses programmatically via Graph PowerShell

**PowerShell Automation**
- Connected to Microsoft Graph using delegated scopes via Device Code flow
- Ran tenant-wide user, device, and group queries using `Get-MgUser`, `Get-MgGroup`, `Get-MgDevice`
- Exported audit reports (users, groups, licenses, sign-in logs) to CSV for documentation
- Validated all configurations via PowerShell output — no screenshot-only evidence

**Security Hardening**
- Configured Microsoft Secure Score baseline tracking
- Reviewed sign-in logs and authentication methods across all user accounts
- Documented identity posture for Conditional Access readiness in Phase 2

---

## Phase 2 — Endpoint, Compliance & Access Security

**Admin Centers Used:** Microsoft Intune · Microsoft Entra ID · Microsoft Purview · Exchange Online

### What Was Built

**Endpoint Governance (Intune)**
- Created 3 Windows Autopilot deployment profiles scoped per persona (Students, Professors, IT Operations) — User-Driven, Entra-joined, OOBE-configured
- Configured macOS and iOS/iPadOS BYOD compliance policies with password, encryption, firewall, and OS version requirements
- Deployed Microsoft Security Baseline for Windows 11 (`Meridian-WIN11-Enterprise-Security-Baseline`, Version 25H2)
- Configured Windows Update ring (`Meridian-WIN11-Pilot-Update-Ring`) with 3-day quality deferral and 7-day feature deferral
- Built Attack Surface Reduction (ASR) rules policy for Windows endpoint hardening

**Conditional Access (Entra ID)**
- Created 8 Conditional Access policies (all Report-Only — zero user disruption):
  - Require MFA for Admin Roles
  - Require MFA for Standard Users
  - Require MFA for All Users
  - Block Legacy Authentication
  - Require MDM-Enrolled and Compliant Device
  - Require Compliant or Hybrid Azure AD Joined Device
  - Require MFA for Admins (template-based)
  - Require MFA for All Users (template-based)
- Created `MFA-Required-Users` security group for scoped CA targeting
- Configured SSPR (Self-Service Password Reset) for all users
- Assigned Helpdesk Administrator RBAC role to Helpdesk-Level1 group and Liam Thomas
- Documented Identity Secure Score: **76.30%**

**Microsoft Purview — Compliance & Data Governance**
- Created 2 custom DLP policies in Simulation mode:
  - `STUDENT_PII_PROTECTION_POLICY` — Canada PHIN, SIN, Physical Addresses across Exchange, SharePoint, OneDrive, Teams, Devices
  - `EVERYONE_STANDARD_DLP_POLICY` — Canada SIN, Bank Account, Driver's License with external sharing block
- Created Compliance Manager alert policies: `HIGH_RISK_DATA_ACCESS_ALERT` and `STUDENT_RECORDS_ACCESS_ALERT`
- Reviewed NIST 800-137 Enterprise Governance Assessment (79% complete, 1712/2163 Microsoft-managed points)
- Documented tenant Compliance Score: **56%**
- Created retention label: `Universal - Keep 7 Years Then Delete`

**Exchange Online — Mail Security**
- Provisioned IT Helpdesk shared mailbox (`helpdesk@nirjala.onmicrosoft.com`)
- Created `Block External Auto-Forwarding` transport rule to prevent data exfiltration via email forwarding
- Documented mail security stack: anti-spam, anti-malware, Safe Attachments, Safe Links, DKIM

**PowerShell Validation**
- Installed PowerShell 7.7 (preview) via Homebrew on macOS
- Connected to Microsoft Graph with `User.Read.All`, `Group.Read.All`, `DeviceManagementManagedDevices.Read.All` scopes
- Queried tenant users, groups, devices, and directory roles via Graph API
- Exported process and system reports from the Meridian Endpoint Operations Console session

---

## Repository Structure

```
Meridian-Institute-M365-Lab/
├── README.md
├── phase-1/
│   ├── index.html
│   └── assets/
│       └── screenshots/
├── phase-2/
    ├── index.html
    └── assets/
└── phase-3-defender-xdr/
    ├── scripts/
    ├── reports/
    └── screenshots/
    ├── index.html
    └── assets/
        └── screenshots/
```

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Microsoft 365 Developer Tenant | Live lab environment (xyz.inc / nirjala.onmicrosoft.com) |
| Microsoft Entra ID | Identity, RBAC, Conditional Access, SSPR |
| Microsoft Intune | Autopilot, compliance policies, security baseline, update rings |
| Microsoft Purview | DLP, Compliance Manager, retention labels |
| Exchange Online | Shared mailbox, transport rules, mail security |
| PowerShell 7.7 + Microsoft Graph SDK | Automation, validation, reporting |
| HTML / CSS / JavaScript | Portfolio evidence pages |
| GitHub Pages | Live hosting |

---

## Certifications Referenced

- AZ-900: Microsoft Azure Fundamentals
- MS-900: Microsoft 365 Fundamentals
- Cisco Networking Essentials
- Anthropic AI Fluency & Framework

---

*Independently designed and executed as a self-directed enterprise simulation — replicating the real-world Microsoft 365 administration challenges faced by IT Operations and Cloud Security teams in mid-size organizations. Every configuration was planned, deployed, validated, and documented without guidance, demonstrating job-ready competency across the Microsoft 365 ecosystem.*

---

## 🌐 Portfolio Ecosystem

This project is part of a multi-repo enterprise IT portfolio covering the full IT lifecycle.

| Layer | Project | Focus |
|---|---|---|
| 01 — Network Foundation | [Enterprise IT Network Diagnostics Toolkit](https://github.com/rahatislamanik-spec/Enterprise-IT-Network-Diagnostics-Toolkit) | DNS · Connectivity · Network Diagnostics |
| 02 — User Lifecycle | [Project Arabesque](https://github.com/rahatislamanik-spec/Project-Arabesque) | Onboarding · Offboarding · M365 Automation |
| 03 — Identity & Security | [Enterprise IT Security Operations Toolkit](https://github.com/rahatislamanik-spec/Enterprise-IT-Security-Operations-Toolkit) | Entra ID · Intune · Defender · Zero Trust |
| 04 — M365 Operations | **You are here** | Exchange · Teams · SharePoint · Purview |

👉 [View Full Portfolio](https://rahatislamanik-spec.github.io/IT-Portfolio-Rahat-Islam-Anik/)
