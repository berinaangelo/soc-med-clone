---
title: public-vs-authenticated-pages
tags: [soc-med-clone, scope, security]
date: 2026-09-01
---

Which MVP pages require login, settled to close a gap the guardrails/schema decisions never
actually enumerated.

**Public — no login required:** a user's profile (name, bio, picture, their posts) and the User
Directory ([[user-directory-entry-point]]) index. This was already implied by the MVP Features
line "profile ... viewable by anyone" but never made explicit as a routing rule. Stays this way
for MVP regardless of the Phase 2 privacy setting — see [[content-visibility-preview]], default
`public` preserves this exact behavior; a user has to opt into something narrower.

**Requires login:** creating/editing/deleting a post, following/unfollowing, viewing your own
Feed (it's personalized to who you follow — meaningless without a session), viewing
Notifications, editing your own profile (see [[profile-editing]] — also ownership-checked, not
just login-checked, same as Posts).

**Root path:** logged-in visitors land on Feed. Logged-out visitors land on the User Directory,
not a separate marketing/landing page — it's public, browsable, and gives a first-time visitor
something to look at immediately (ties into "I Found My People," [[god-moments]] #2) without
building a page whose only job is to explain the app before anyone can use it.

**How to apply:** `before_action :authenticate_user!` on Posts create/edit/destroy, Follows,
Feed, and Notifications controllers only. Profiles and the User Directory controllers stay
open — no `authenticate_user!`, but views still need the null-safe `current_user&.…` guard from
[[implementation-guardrails]] for anything that changes based on whether a viewer is logged in
(e.g. showing a Follow button vs. nothing).
