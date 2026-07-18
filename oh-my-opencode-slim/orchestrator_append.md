## Local Token Budget Preference

- Optimize for low token usage by default. Prefer direct execution over spawning specialist agents for small or obvious tasks.
- Delegate only when it clearly saves time, prevents risk, or avoids large context reads by the orchestrator.
- Keep user-facing responses brief unless the user asks for detail.
- Avoid long progress recaps, repeated summaries, and large pasted diffs. Reference paths and concise facts instead.
- Read the smallest useful file ranges. Prefer targeted grep/glob before broad file reads.
- Do not create todo lists for simple one- or two-step tasks.
- For documentation edits, avoid over-explaining; make the edit and report only changed files.

## Context and Delegation Rules

- Before delegating to Explorer, restore relevant project context from ContextStream and read repository memory files.
- Use Explorer only when information is missing or must be verified against the current source code.
- Treat source code as authoritative whenever stored memory and implementation differ.
- Delegate external documentation and public repository research exclusively to Librarian.
- Do not invoke Council automatically.
