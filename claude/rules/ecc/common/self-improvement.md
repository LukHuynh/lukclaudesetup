# Self-Improvement Loop

## Session Start

At the start of each session, check for project-level lessons:

```bash
[ -f tasks/lessons.md ] && cat tasks/lessons.md
```

Review any lessons relevant to the current task before beginning work.

## After Every User Correction

When the user corrects your approach, output, or reasoning:

1. Identify the **pattern** — not just the specific instance
2. Append to `tasks/lessons.md` (create if absent):

```markdown
## Lesson: YYYY-MM-DD

**What happened:** [brief description of the mistake]
**Root cause:** [why it happened]
**Rule going forward:** [concrete rule to prevent recurrence]
```

3. Apply the rule immediately within this session

## Verification Gate

Before marking ANY task complete, confirm all of the following:

- [ ] Behavior is proven: tests pass, logs are clean, UI works as expected
- [ ] Diff reviewed: "Would a staff engineer approve this?"
- [ ] Root cause addressed — no hacky workaround, no `// TODO: fix later`
- [ ] Minimal footprint: only necessary code was changed

If any item is unchecked, keep the task `in_progress` and resolve it first.

## Elegance Check

For non-trivial changes (new feature, refactor, architectural decision):

> "Knowing everything I know now, is there a more elegant solution?"

If the current approach feels hacky or over-engineered, stop and implement the elegant version before presenting. Skip this for obvious, simple fixes — do not over-engineer.

## Autonomous Execution

When given a bug report or failing test:

- Diagnose and fix. Do not ask for hand-holding.
- Point at the specific log line, error message, or test output.
- Resolve it. Zero context switching required from the user.
- CI failing? Fix the failing tests without being told how.

## Stop-and-Replan Rule

If something goes sideways mid-task:

1. **STOP** — do not keep pushing through
2. Re-enter plan mode with updated context
3. Revise `tasks/todo.md` to reflect new understanding
4. Check in with user only if the scope has fundamentally changed

Never paper over a blocker with a workaround. Solve the root cause or stop and replan.
