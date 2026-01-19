import json
import sys

def validate_policy(policy):
    violations = []
    for stmt in policy.get("Statement", []):
        if stmt.get("Effect") == "Allow" and stmt.get("Action") == "*":
            violations.append("Wildcard action detected")
    return violations

if __name__ == "__main__":
    policy_file = sys.argv[1]
    with open(policy_file) as f:
        policy = json.load(f)

    issues = validate_policy(policy)
    if issues:
        print("Baseline violations:")
        for issue in issues:
            print(f"- {issue}")
        sys.exit(1)

    print("IAM baseline compliant")
