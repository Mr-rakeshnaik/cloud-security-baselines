# Network Exposure Baseline

## Objective
Reduce attack surface by preventing unintended public exposure of cloud resources.

## Policy Requirements
- Public ingress denied by default
- Security groups / NSGs must not allow 0.0.0.0/0 to admin ports
- Metadata services access restricted to required workloads only
- Network flow logs enabled for monitoring

## Enforced By
- Terraform network guardrails
- Cloud-native network policies
- SIEM and flow log analysis

## Attack Paths Mitigated
- AP-002: Public Workload Exposure → Credential Access

## Framework Mapping
- NIST 800-53: SC-7, AC-4
- CIS Foundations: Network Controls
