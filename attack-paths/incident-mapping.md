# Incident ↔ Attack Path Mapping

This document maps real-world cloud security incidents to predefined
attack paths and identifies control failures, detection gaps, and
preventive improvements.

The objective is to ensure incidents directly inform security baselines.

---

## Incident 001: Privileged Account Compromise

### Incident Summary
A user with Contributor-level access was compromised via phishing,
resulting in unauthorized role escalation at the subscription level.

### Mapped Attack Path
- **AP-001: IAM Misconfiguration → Subscription Takeover**

### Attack Chain
1. Credential compromise via phishing
2. Attacker enumerated IAM role assignments
3. Privileged role assigned at subscription scope
4. Persistence established using new service principal

### Control Gaps Identified
- Standing privileged role assignment
- MFA not enforced for privileged access
- No alert on role assignment creation

### Detection & Response
- Detected via anomalous API activity in SIEM
- Roles revoked and credentials rotated
- Security review initiated

### Preventive Improvements
- Enforced JIT / PIM for privileged roles
- Added SIEM alert on privileged role assignments
- Updated IAM baseline policy

---

## Incident 002: Publicly Exposed Workload Exploitation

### Incident Summary
A cloud VM exposed to the internet was exploited, allowing access to
cloud credentials via metadata service.

### Mapped Attack Path
- **AP-002: Public Workload Exposure → Credential Access**

### Attack Chain
1. External scan discovered exposed service
2. Application vulnerability exploited
3. Metadata service accessed
4. Temporary credentials used to enumerate resources

### Control Gaps Identified
- No default-deny network baseline
- Metadata access not restricted
- Insufficient network monitoring

### Detection & Response
- Detected via unusual API calls
- VM isolated and credentials rotated
- Forensic analysis completed

### Preventive Improvements
- Implemented default-deny NSG / Security Group rules
- Restricted metadata service access
- Enabled flow log monitoring

---

## Incident 003: Logging Disabled to Evade Detection

### Incident Summary
An attacker with elevated permissions disabled cloud logging to evade
monitoring before performing unauthorized actions.

### Mapped Attack Path
- **AP-003: Logging Disabled → Undetected Persistence**

### Attack Chain
1. Attacker obtained overprivileged access
2. Disabled diagnostic settings
3. Performed malicious actions without detection
4. Re-enabled logging post-activity

### Control Gaps Identified
- Logging configurations mutable by broad roles
- No alert on logging changes

### Detection & Response
- Detected during compliance review
- Immediate audit initiated
- Permissions corrected

### Preventive Improvements
- Immutable logging enforced via Terraform
- Alerts added for logging configuration changes
- Logging baseline updated

---

## Feedback Loop

| Incident | Attack Path | Policy Updated | Terraform Updated |
|--------|-------------|---------------|------------------|
| 001 | AP-001 | iam-baseline.md | azure/main.tf |
| 002 | AP-002 | network-baseline.md | aws/main.tf |
| 003 | AP-003 | logging-baseline.md | azure/main.tf |

---

## Key Outcome

Every incident:
- Maps to a known attack path
- Results in policy updates
- Drives preventive control improvements
- Improves future detection capability
