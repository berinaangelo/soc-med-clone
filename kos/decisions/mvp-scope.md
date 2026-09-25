---
title: mvp-scope
tags: [soc-med-clone, scope, ruthless-simplicity]
date: 2026-09-01
---

MVP scope for soc-med-clone (Friendster rebuild), after a ruthless-simplicity pass (five-gate
review, run twice — see revision history below). See [PLAN.md](../PLAN.md) for the one-sentence
scope and primary flow this supports.

**Kept:** Devise auth (sign up/log in/log out), User profile (name/bio/profile_picture URL — see
[[data-model-schema]] — created at signup, editable afterward by its owner, see
[[profile-editing]]), Posts (create/view on profile/view in feed/edit/delete — owner only,
500-char cap), User Directory (browse-all entry point for Follow — see
[[user-directory-entry-point]]),
Follow/unfollow with follower/following counts (unique pair, no self-follow), reverse-
chronological Feed from followed users, Notifications (follow alerts only, no self-notify).

**Cut for v1, ranked by post-MVP significance** (highest first — build these soonest once
triggered):

1. **Comments** — closes the "I'm Part of Something" god-moment gap flagged in
   [[god-moments]]; MVP has zero reply mechanism. Build first once MVP ships — highest-impact,
   lowest-effort cut.
2. **Likes** — a second, lighter-weight "Someone Noticed Me" signal beyond follows; natural pair
   with Comments, same effort tier.
3. **Photo uploads (Active Storage)** — replaces the plain-URL `profile_picture` field, which
   fails the grandma test (pasting an image URL isn't zero-instruction) but was kept for MVP
   build-time budget. Build once that friction is actually reported, not preemptively.
4. **Search** — replaces the User Directory once the user list is too long to browse. Directory
   is the deliberate MVP stand-in — see [[user-directory-entry-point]].
5. **Direct Messages** — schema already sketched in [[direct-messages-preview]] so this isn't
   designed from scratch when picked up.
6. **Friend Requests (mutual, vs. one-directional Follow)** — only if reciprocity actually gets
   requested; Follow is intentionally asymmetric (Twitter model), not symmetric (Facebook
   model), by design, not oversight. **Update 2026-09-02:** that trigger fired — decided
   alongside Follow, not replacing it, schema and UI sketched in [[friend-requests-preview]].
   Still cut/not built, same status as every other item on this list — only the open design
   question got resolved, not the build order.
7. **Content visibility settings** (only me / friends / public, per [[content-visibility-preview]])
   — build once real users, not demo accounts, start asking not to be fully public. MVP default
   is public for everyone, matching [[public-vs-authenticated-pages]]; this only matters once
   someone wants narrower than that default.
8. **Two-factor authentication** (TOTP, per [[two-factor-auth-preview]]) — build once there are
   real accounts worth protecting, not preemptively for seeded demo users.
9. **Email confirmations** — build once this leaves "portfolio demo" and starts taking real
   signups from strangers.
10. **Groups, Hashtags, Admin Panel** — **Update 2026-09-02:** reclassified from a permanent cut to
    deferred; moved to [[future-considerations]] alongside Content moderation and the
    compromised-account indicator, same "named but not planned" status as those two. Original
    reasoning kept as history, not overwritten, same convention as this file's own revision log:
    cut on purpose per the guiding principle ("if a feature doesn't directly help someone feel
    seen, connected, or delighted — it's out"), no trigger identified at the time.

**Revision history:** first pass added the User Directory (Follow had no way to find anyone to
follow — a hard usability blocker, not a partial-delivery nuance). Second pass caught a
build-order arithmetic error (2h20m, not 2h10m — see [[build-order-and-success-criteria]]) and
flagged the Comments gap above as a wording/scope note, not a blocker. Third pass (data-gathering
audit) added Post edit/delete to Kept — [[implementation-guardrails]] had already been assuming
ownership checks on those actions before they were actually in scope — and dropped Deployment
from the plan as undecided rather than a stale Render/Heroku placeholder (see [[tech-stack]]).
Fourth pass (2026-09-02) reclassified cut #10 (Groups/Hashtags/Admin Panel) from a permanent cut to
deferred, moving it into [[future-considerations]] — a status correction, not new planning; nothing
about scope/schema/trigger for those three features was actually decided in this pass.
