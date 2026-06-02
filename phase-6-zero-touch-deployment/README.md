# Phase 6 – Zero-Touch Deployment Architecture

## Overview

This phase presents the final zero-touch endpoint deployment architecture for Meridian Institute.

The workflow integrates Microsoft Entra ID, Microsoft 365 licensing, Conditional Access, Microsoft Intune, Windows Autopilot, Microsoft Defender, and Windows 11 endpoint provisioning into a single automated deployment model.

---

## Objective

Reduce manual onboarding effort by automating user provisioning, security enforcement, device enrollment, application deployment, and endpoint configuration.

---

## Workflow Architecture

HR Onboarding Request

↓

Microsoft Entra ID

↓

Department Security Groups

↓

Microsoft 365 E3 Licensing

↓

Conditional Access Policies

↓

Microsoft Intune Enrollment

↓

Windows Autopilot Provisioning

↓

Microsoft Defender Protection

↓

Windows 11 Corporate Device

↓

Employee Ready for Work

---

## Employee Scenario

Employee:

Sarah Johnson

Department:

Human Resources

Onboarding Process:

1. User account created in Entra ID
2. Assigned to Meridian-HR group
3. Microsoft 365 E3 license assigned
4. Conditional Access policies enforced
5. Device enrolled through Intune
6. Windows Autopilot provisions device
7. Microsoft Defender secures endpoint
8. Employee signs in and begins work

---

## Technologies Used

* Microsoft Entra ID
* Microsoft 365 E3
* Microsoft Intune
* Conditional Access
* Windows Autopilot
* Microsoft Defender
* Windows 11

---

## Business Outcome

This architecture demonstrates how Meridian Institute can standardize employee onboarding, improve endpoint security, and reduce IT operational effort through a modern zero-touch deployment strategy.

Current Completion: ~90%
