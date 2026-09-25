---
title: implementation-guardrails
tags: [soc-med-clone, security, backend]
date: 2026-09-01
---

Five constraints on *how* the MVP features in [[mvp-scope]] get built — not separate features,
not a cleanup pass to run afterward. Apply each at the point the relevant feature is built.

**Why:** a 2-hour MVP timeline is exactly the condition under which secrets get hardcoded,
ownership checks get skipped, and empty states get left blank — these are the specific failure
modes to guard against given that pressure, not generic advice.

1. **No hardcoded secrets.** DB credentials, Rails `SECRET_KEY_BASE`, and the Devise secret live
   in Rails encrypted credentials (`rails credentials:edit`) or `.env` (via `dotenv-rails`) —
   never in `database.yml` or committed source. Check the diff before each commit.
2. **Ownership checks, not just login checks.** `before_action :authenticate_user!` is not
   enough — a post's `edit`/`update`/`destroy` actions must also confirm
   `@post.user == current_user` (404 or redirect otherwise). Same rule applies to Direct
   Messages once built — see [[direct-messages-preview]].
3. **Strong params everywhere.** Every controller action that writes from user input goes
   through `params.require(...).permit(...)` — no mass-assignment of `user_id` or `read` from
   the client.
4. **Null-safe lookups.** `current_user` can be `nil` in any view rendered for logged-out
   visitors (e.g. a public profile page) — guard with `current_user&.following?(user)` rather
   than assuming a session.
5. **Fallback on empty states.** Empty feed, zero followers, no notifications yet — each needs
   an explicit "nothing here yet" state, not a blank page or a raw `[]`.

**How to apply:** these aren't a checklist to run once at the end — check each one against the
specific feature being built at that step of [[build-order-and-success-criteria]].
