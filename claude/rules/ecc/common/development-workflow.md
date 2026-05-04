# Development Workflow

> This file extends [common/git-workflow.md](./git-workflow.md) with the full feature development process that happens before git operations.

The Feature Implementation Workflow describes the development pipeline: research, planning, TDD, code review, and then committing to git.

## Guiding Behaviors

**Plan mode for non-trivial tasks:** Enter plan mode for ANY task with 3+ steps or an architectural decision. Write the plan to `tasks/todo.md` with checkable items. Check in with the user before starting implementation.

**Stop-and-replan:** If blockers emerge mid-task, STOP. Do not push through. Re-enter plan mode with updated context and revise `tasks/todo.md`.

**Verification before done:** Never mark a task complete without proving it works — tests pass, logs clean, UI behaves correctly. Ask: "Would a staff engineer approve this?"

**Autonomy on bugs:** When given a bug report or failing test, diagnose and fix it. Do not ask for hand-holding. Point at the specific log, error, or test output, then resolve it.

**Elegance check (non-trivial only):** Before finalizing a non-trivial change, pause and ask: "Is there a more elegant solution?" Skip for simple, obvious fixes — do not over-engineer.

**Self-improvement:** After any user correction, update `tasks/lessons.md` with the pattern and a rule that prevents recurrence. See [self-improvement.md](./self-improvement.md).

## Task Management

For any task with 3+ steps:

1. Write `tasks/todo.md` with checkable items before starting
2. Check in with user to confirm the plan
3. Mark items complete immediately as you finish them — do not batch
4. Provide a high-level summary after each step
5. Add a `## Results` section to `tasks/todo.md` when done

## Feature Implementation Workflow

0. **Research & Reuse** _(mandatory before any new implementation)_
   - **GitHub code search first:** Run `gh search repos` and `gh search code` to find existing implementations, templates, and patterns before writing anything new.
   - **Library docs second:** Use Context7 or primary vendor docs to confirm API behavior, package usage, and version-specific details before implementing.
   - **Exa only when the first two are insufficient:** Use Exa for broader web research or discovery after GitHub search and primary docs.
   - **Check package registries:** Search npm, PyPI, crates.io, and other registries before writing utility code. Prefer battle-tested libraries over hand-rolled solutions.
   - **Search for adaptable implementations:** Look for open-source projects that solve 80%+ of the problem and can be forked, ported, or wrapped.
   - Prefer adopting or porting a proven approach over writing net-new code when it meets the requirement.

1. **Plan First**
   - Use **planner** agent to create implementation plan
   - Generate planning docs before coding: PRD, architecture, system_design, tech_doc, task_list
   - Identify dependencies and risks
   - Break down into phases

2. **TDD Approach**
   - Use **tdd-guide** agent
   - Write tests first (RED)
   - Implement to pass tests (GREEN)
   - Refactor (IMPROVE)
   - Verify 80%+ coverage

3. **Code Review**
   - Use **code-reviewer** agent immediately after writing code
   - Address CRITICAL and HIGH issues
   - Fix MEDIUM issues when possible

4. **Commit & Push**
   - Detailed commit messages
   - Follow conventional commits format
   - See [git-workflow.md](./git-workflow.md) for commit message format and PR process

5. **Pre-Review Checks**
   - Verify all automated checks (CI/CD) are passing
   - Resolve any merge conflicts
   - Ensure branch is up to date with target branch
   - Only request review after these checks pass
