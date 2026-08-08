# Meridian Institute M365 Lab Evidence Map

This map helps reviewers quickly connect each project phase to the evidence in the repository.

## Evidence Summary

| Phase | Evidence Type | Location | What It Proves |
|---|---|---|---|
| Phase 1 | HTML evidence gallery | `phase-1/index.html` | Identity baseline, Entra users/groups, Graph PowerShell validation, sign-in and audit review |
| Phase 2 | HTML evidence gallery and screenshots | `phase-2/index.html`, `phase-2/assets/screenshots/` | Intune policy configuration, Conditional Access design, Purview DLP, Exchange Online controls, PowerShell validation |
| Phase 3 | PowerShell script, CSV reports, screenshots | `phase-3-defender-xdr/` | Defender XDR posture audit, Secure Score review, risky user and alert checks |
| Phase 4 | CSV reports and screenshots | `phase-4-user-onboarding-automation/` | Graph PowerShell onboarding workflow, group assignment, licensing, user validation |
| Phase 5 | PowerShell script, CSV reports, screenshots | `phase-5-endpoint-compliance/` | Conditional Access audit, Intune compliance policy audit, managed-device inventory check |
| Phase 6 | Architecture documentation | `phase-6-zero-touch-deployment/README.md` | End-to-end zero-touch deployment design connecting identity, licensing, CA, Intune, Autopilot, and Defender |

## Public Evidence Counts

| Area | Count |
|---|---:|
| Phase 1 embedded evidence items | 43 |
| Phase 2 screenshot assets | 116 |
| Phase 3 screenshots | 5 |
| Phase 4 screenshots | 14 |
| Phase 5 screenshots | 4 |
| CSV reports | 9 |
| PowerShell scripts | 2 |

## Review Notes

- Public tenant identifiers are sanitized.
- Conditional Access evidence is intentionally Report-Only for lab safety.
- Phase 5 audits 9 Conditional Access policies because one BYOD web-only access policy was added after the initial Phase 2 policy build.
- Intune and Autopilot evidence focuses on policy configuration and reference architecture rather than a production endpoint fleet.
- Production rollout would require break-glass accounts, staged CA enablement, rollback steps, device enrollment testing, and licensing validation.
- No production customer data, passwords, tokens, or API keys are intentionally included.
