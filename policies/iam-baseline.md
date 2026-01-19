# IAM Security Baseline

## Objective
Prevent unauthorized privilege escalation and account takeover by enforcing
least-privilege access and strong identity controls.

## Policy Requirements
- No wildcard permissions (`*`) in IAM policies
- No standing administrative roles assigned to users
- Privileged access must be time-bound (JIT / PIM)
- MFA required for all privileged and console access
- Service principals must use scoped permissions only

## Enforced By
- Terraform IAM role definitions
- Python policy validation (`validate_baseline.py`)
- SIEM alerts on privileged role assignments

## Attack Paths Mitigated
- AP-001: IAM Misconfiguration → Subscription/Account Takeover

## Framework Mapping
- NIST 800-53: AC-2, AC-6, IA-2
- CIS AWS/Azure Foundations: IAM Controls
