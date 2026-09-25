---
title: testing-approach
tags: [soc-med-clone, testing]
date: 2026-09-01
---

Minitest — Rails 8's default, no extra setup (no RSpec/FactoryBot install cost).

**Why:** the plan's Notes originally said "focus on clean, well-tested code" with no framework
named and no test step anywhere in the 2-hour build order — an unenforceable aspiration as
written. Minitest was picked specifically because it costs zero setup time against a tight
budget; anything requiring a Gemfile addition and generator config wasn't worth it here.

**Scope of "well-tested" for this MVP:** model validations plus the constraints in
[[data-model-schema]] (Follow uniqueness, no self-follow, no self-notification) and the
ownership checks in [[implementation-guardrails]] each get one Minitest case. **Not** in scope
for MVP: full request/system test coverage — that's beyond what a 2-hour build can carry.
