---
title: build-order-and-success-criteria
tags: [soc-med-clone, scope]
date: 2026-09-01
---

The timeboxed build sequence for the MVP in [[mvp-scope]], and the definition of done.

## Build order

| Step | Task | Time |
| :--- | :--- | :--- |
| 1 | `rails new` + Devise setup | 10 min |
| 2 | User profiles (name, bio, photo URL) | 15 min |
| 3 | Posts (create, show on profile, edit, delete — owner only) | 30 min |
| 3.5 | User directory (index of all users, links to profiles) — see [[user-directory-entry-point]] | 10 min |
| 4 | Follow system (follow/unfollow, counts) — depends on step 3.5 existing first | 45 min |
| 5 | Feed (posts from followed users) | 10 min |
| 6 | Notifications (follow alerts; bell icon + `/notifications` page, simplest version — see [[notifications-ui]]) | 30 min |
| 7 | Seed data (dummy demo users/posts/follows — see [[seed-data]]) | 15 min |
| **Total** | | **~2 hours 45 min** |

**Corrected three times:** an earlier draft summed this to "~2 hours 10 min" — arithmetic error
caught on a second review pass (10+15+20+10+45+10+30 = 140 min = 2h20m, not 2h10m). Then Post
edit/delete was added to scope (was guarded against in [[implementation-guardrails]] before it
was actually in [[mvp-scope]] — now consistent), adding 10 min to step 3: 150 min = 2h30m. Then
step 7 (seed data) was added: 165 min = 2h45m. Apply [[implementation-guardrails]] at each step,
not as a separate final pass.

## Success criteria (when are we done?)

- [ ] A user can sign up and create a profile
- [ ] A user can post a text status
- [ ] A user can edit or delete their own post (and only their own)
- [ ] A user can browse a list of other users
- [ ] A user can follow another user
- [ ] A user sees a feed of posts from people they follow
- [ ] A user gets a notification when someone follows them
- [ ] The demo has seeded dummy users so Directory/Feed aren't empty on first load

Deployment is not a success criterion yet — see [[tech-stack]], dropped as undecided rather than
committed to a specific free-tier host.

## Guiding principle

> "If a feature doesn't directly help someone feel seen, connected, or delighted — it's out."

This is the standing test for anything proposed after this list is "done" — see [[mvp-scope]]
for how it was applied to the post-MVP cut list.
