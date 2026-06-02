# Phase 4 – User Onboarding Automation

## Current Completion

✅ Complete

---

## Objective

Automate Microsoft Entra ID user onboarding using Microsoft Graph PowerShell.

This phase demonstrates:

* User creation
* Department security groups
* Group membership automation
* Microsoft 365 licensing
* MFA readiness
* User validation
* Evidence collection
* Reporting and auditing

---

## Environment

### Tenant

nirjala.onmicrosoft.com

### Administrator

Md Rahat Islam Anik

### Tools

* Microsoft Graph PowerShell
* Microsoft Entra ID
* Microsoft 365 E3
* PowerShell 7
* Microsoft Authenticator

---

## Department Groups

The following department-based security groups were created to support role-based access control and onboarding automation:

* Meridian-HR
* Meridian-Finance
* Meridian-Faculty
* Meridian-IT
* Meridian-Administration

---

## User Onboarding Workflow

The onboarding process was automated using Microsoft Graph PowerShell.

### Workflow

1. Create user account
2. Assign department security group
3. Configure usage location
4. Assign Microsoft 365 E3 license
5. Verify group membership
6. Validate user access
7. Collect onboarding evidence
8. Export reporting data

---

## Test User

### Sarah Johnson

**Department:** Human Resources

**Group Membership:** Meridian-HR

**License:** Microsoft 365 E3

**Usage Location:** Canada (CA)

---

## Evidence Collection

### Reports

* Meridian-GroupAssignments.csv
* Meridian-GroupAssignments-Updated.csv
* Sarah-Johnson-Onboarding-Evidence.csv

### Screenshots

#### Initial Automation Workflow

01 – Entra Groups Created

02 – Department Assignments

03 – Group Membership Verification

04 – Sarah Johnson Creation

05 – Sarah HR Assignment

06 – M365 E3 License Assignment

07 – License Validation

08 – PowerShell Onboarding Workflow

09 – Onboarding Evidence Verification

#### User Validation Testing

10 – Sarah First Sign-In

11 – Sarah Outlook Access

12 – Sarah Microsoft 365 Portal Access

13 – Sarah Sign-In Logs

14 – Sarah HR Group Membership Validation

---

## User Validation Testing

Following automated onboarding and license assignment, a complete validation workflow was performed using the newly provisioned HR employee account.

### Validation Activities

* Successful Microsoft Entra ID authentication
* Microsoft Authenticator MFA registration
* Microsoft 365 portal access verification
* Outlook mailbox provisioning validation
* OneDrive access verification
* Microsoft Teams access verification
* SharePoint access verification
* Sign-in log validation
* Department group membership validation

### Validation Results

The onboarding workflow successfully provisioned a fully operational employee account with Microsoft 365 services, security controls, and departmental access assignments.

The user was able to authenticate, access licensed services, and generate auditable sign-in activity within Microsoft Entra ID.

---

## Skills Demonstrated

### Identity & Access Management

* Microsoft Entra ID
* Identity Governance
* RBAC
* Security Groups
* User Lifecycle Management

### Automation & Administration

* Microsoft Graph PowerShell
* PowerShell Automation
* User Provisioning
* License Assignment
* Reporting & Documentation

### Security

* Multifactor Authentication (MFA)
* Authentication Validation
* Sign-In Monitoring
* Access Verification

---

## Business Outcome

This phase demonstrates a complete enterprise user onboarding lifecycle using Microsoft Entra ID, Microsoft Graph PowerShell, Microsoft 365 licensing, multifactor authentication, group-based access control, and service validation.

The onboarding process reduces manual administrative effort, standardizes user provisioning, and improves operational consistency across the organization.

---

## Phase Status

✅ Complete

---

## Next Phase

### Phase 5 – Endpoint Compliance & Conditional Access

Focus Areas:

* Conditional Access Policies
* Intune Compliance Policies
* Device Security Baselines
* Endpoint Compliance Reporting
* Corporate Device Management
