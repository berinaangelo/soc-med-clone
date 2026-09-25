---
title: seed-data
tags: [soc-med-clone, scope]
date: 2026-09-01
---

`db/seeds.rb` ships dummy users (with posts and a handful of follow relationships between them)
so the app isn't empty on first load.

**Why:** built for a solo-developer portfolio showcase (see [PLAN.md](../PLAN.md)) — an empty
Directory/Feed on first open is a bad demo regardless of how correct the code underneath is.

**How to apply:** hand-write ~5–8 fake users directly in `db/seeds.rb` (name, bio, a couple of
posts each, a few follow pairs so the Feed and follower/following counts aren't all zero) — no
Faker/FactoryBot gem needed, the list is small enough to write out. Run via `rails db:seed`,
idempotent (`find_or_create_by`) so re-running it doesn't duplicate rows. Added as step 7 of
[[build-order-and-success-criteria]].
