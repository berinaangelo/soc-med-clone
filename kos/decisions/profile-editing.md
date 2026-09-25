---
title: profile-editing
tags: [soc-med-clone, scope, ux]
date: 2026-09-01
---

Editing your own profile after signup is in MVP scope — closing a gap `mvp-scope.md`'s Kept list
and `PLAN.md`'s primary flow never actually named (both only covered profile *creation* at
signup; nothing said a user could change it afterward).

**Why:** a profile a user can never revise after their first five minutes in the app fails
`god-moments.md` #3, "This Is Mine" — personal space you can't reshape isn't really yours. Also a
plain usability gap: `data-model-schema.md`'s `profile_picture` is a pasted URL, exactly the kind
of field people get wrong on the first try and need to fix.

**Scope: exactly the three app-owned fields from `data-model-schema.md`** — `name` (required),
`bio` (optional), `profile_picture` (optional URL) — nothing else. Devise's own fields (`email`,
password) are a separate concern ([[devise-modules]]) and are **not** part of this screen or this
decision; if/when email or password changes are wanted, that's Devise's own edit-registration
flow, scoped separately.

**Requires login + ownership** — added to [[public-vs-authenticated-pages]]'s Requires-login list.
Only the profile's own owner can reach or submit this form; `@user == current_user` the same
ownership-check pattern already decided for Posts in [[implementation-guardrails]].

**Entry point:** an "Edit profile" affordance on the owner's own profile view
([ux/pages/profile.html](../ux/pages/profile.html)), next to where the Follow control sits for
every other viewer — the two are mutually exclusive per state, already true in that mockup.

**How to apply:** add a `users#edit`/`users#update` pair (or fold into Devise's registration
controller if that ends up simpler at build time — not decided here, this note only settles
product scope and field list, not the Rails-level implementation shape). Mockup:
[ux/pages/edit-profile.html](../ux/pages/edit-profile.html).

See [[data-model-schema]] for the field set this reuses verbatim, [[god-moments]] for the "This Is
Mine" reasoning, and [[mvp-scope]] for the Kept-list update this triggers.
