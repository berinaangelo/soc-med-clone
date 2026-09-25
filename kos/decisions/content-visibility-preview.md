---
title: content-visibility-preview
tags: [soc-med-clone, phase-2, data-model, privacy]
date: 2026-09-01
---

Forward-looking preview of a Phase 2 privacy feature — **not MVP, not committed, not being
built now.** Noted here so the shape is decided before it's picked up, same reasoning as
[[direct-messages-preview]].

**What it is:** an account-level setting, not a per-post toggle. Two enum fields on User:
`posts_visibility` and `comments_visibility` (once Comments exists — see [[mvp-scope]] cut #1),
each one of `public` / `friends` / `only_me`, default `public` — so turning this feature on
doesn't silently change behavior for accounts that never touch the setting; MVP's current
"viewable by anyone" default (see [[public-vs-authenticated-pages]]) is preserved unless a user
opts into something narrower.

**"Friends" means mutual follow, not a separate concept.** Follow is intentionally
one-directional ([[mvp-scope]] cut #6 — Twitter model, not Facebook). Rather than adding a
Friendship table, "friends" for visibility purposes is computed: viewer and author both have a
Follow row pointing at each other. No schema addition beyond the two enum columns.

**Update 2026-09-02:** [[mvp-scope]] cut #6's reciprocity trigger fired — see
[[friend-requests-preview]]. "Friends" now means an accepted `FriendRequest` between viewer and
author, not computed mutual-follow — a real schema addition after all. The reasoning above still
explains why it was computed-only originally (no Friend Requests existed yet to check against);
kept as history, not overwritten.

**Enforcement isn't a single flat scope.** Because visibility is per-author (not global), a
feed or profile listing has to check each post's author's setting against the viewer's
relationship to that specific author — not one WHERE clause across every author at once. Whoever
builds this should preload the viewer's Follow rows once per request and check membership in
memory, not run a mutual-follow query per post (N+1 risk).

**How to apply when Phase 2 is picked up:** add the two enum columns to User, add a
`Post.visible_to(viewer)` (and later `Comment.visible_to(viewer)`) class method encapsulating the
three-way rule above, and use it everywhere posts/comments are listed (profile, feed). Does not
affect the User Directory ([[user-directory-entry-point]]) — that lists name/bio only, never
post/comment content.
