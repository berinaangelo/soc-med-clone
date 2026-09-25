---
title: user-directory-entry-point
tags: [soc-med-clone, scope, ux]
date: 2026-09-01
---

A plain "browse all users" index page (name, bio, link to profile — no search, no filtering) is
in MVP scope, not deferred to Phase 2 alongside Search.

**Why:** the original MVP feature set (Auth, Profile, Posts, Follow, Feed, Notifications) had no
way for a user to find anyone to follow — you'd need to already know a profile URL. That leaves
the plan's own god moment #2, "I Found My People" (see [[god-moments]]), completely undelivered,
and makes the Follow feature unusable in a real demo, not just incomplete. This is a hard
usability blocker, different in kind from features that are cut because MVP only delivers part
of the eventual experience (e.g. Comments, [[mvp-scope]] cut #1) — Follow has no entry point at
all without it.

**How to apply:** build a plain index action + view, no query params, no pagination logic beyond
what Rails gives for free. This is explicitly *not* the Phase 2 "Search" feature
([[mvp-scope]] cut #4) — no filtering, no ranking, just a full list. Costs roughly 10 minutes in
the build order (step 3.5 of [[build-order-and-success-criteria]]), immediately after Posts and
before Follow, since Follow depends on it.

**Query cap (added, no pager UI still holds):** the index action fetches with a hard
`.limit(9)` (e.g. `User.order(:created_at).limit(9)`), not `User.all`. This page is public with
no `authenticate_user!` guard ([[public-vs-authenticated-pages]]), so an unbounded query is an
open performance/DoS surface as the user table grows — capping it doesn't reintroduce
pagination (no page param, no pager UI, still just "what Rails gives for free" plus a fixed
limit) and doesn't change the "no filtering/ranking" rule above. 9 was picked to line up evenly
with the directory mockup's 3-column desktop grid (3 full rows, no dangling partial row). First
applied in the [directory mockup](../ux/pages/directory.html).
