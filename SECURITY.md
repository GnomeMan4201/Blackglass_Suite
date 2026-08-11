# Security Policy

## Reporting a vulnerability

Do **not** publish a suspected vulnerability before it can be reviewed.

Preferred reporting path:

1. Use **Security → Report a vulnerability** for this repository when GitHub private vulnerability reporting is available.
2. Otherwise email **badbanana@proton.me** with the subject `Blackglass_Suite security report`.

Include the affected commit/version, exact component, minimal reproduction, expected invariant, observed behavior, impact, and any proposed mitigation. Do not send unrelated credentials, third-party private data, or live payloads that are not necessary to reproduce the issue.

## Security-relevant scope

Blackglass intentionally contains dual-use artifact-generation and adversarial-research code. A report is most useful when it identifies an **unintended** security boundary failure rather than merely describing behavior the project explicitly exists to model.

Examples include:

- command construction or execution outside the documented operator action;
- unsafe path/archive handling or writes outside an intended output directory;
- accidental network activity in a workflow documented as local/offline;
- secret exposure or credential persistence;
- generated artifacts executing during generation/preview when they should only be emitted as files;
- CI/release workflows with unnecessary write or secret access;
- dependency issues with a meaningful exploit path in the maintained code.

## Supported state

Report findings against the current default branch or identify the exact historical release/commit involved. Historical research artifacts may intentionally preserve old behavior and are not assumed to receive backported fixes.

## Disclosure

I aim to acknowledge reproducible reports within seven days. Validation and remediation timing depends on severity, reproducibility, and project status; no fixed patch deadline is promised before triage.

Confirmed fixes should be documented when practical. Reporter credit is welcome unless anonymity is requested.

## Research boundary

Testing this repository does not authorize testing third-party systems. Use generated artifacts and adversarial modules only in environments you own or are explicitly authorized to assess.
