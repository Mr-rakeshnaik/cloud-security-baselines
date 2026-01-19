# Logging & Monitoring Baseline

## Objective
Ensure complete visibility of cloud activity and prevent attacker logging evasion.

## Policy Requirements
- Cloud activity logging enabled at subscription/account level
- Logs must be centralized and retained for a minimum of 30 days
- Logging configurations must be immutable to non-admin users
- Alerts must trigger on logging configuration changes

## Enforced By
- Azure Diagnostic Settings (Terraform)
- AWS CloudTrail (Terraform)
- SIEM monitoring and alerts

## Attack Paths Mitigated
- AP-003: Logging Disabled → Undetected Persistence

## Framework Mapping
- NIST 800-53: AU-2, AU-6
- CIS Foundations: Logging Controls
