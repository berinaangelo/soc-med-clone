---
title: future-considerations
tags: [soc-med-clone, backlog]
date: 2026-09-01
---

Topics named but **not yet planned** — no scope, no schema, no trigger decided. Unlike
[[direct-messages-preview]] / [[content-visibility-preview]] / [[two-factor-auth-preview]] (which
have an actual design sketched even though unbuilt), these are just markers so they aren't lost
before their own planning session:

- **Content moderation** — reporting/flagging posts or users, and whatever review process sits
  behind it. Nothing decided: no report model, no moderator role, no action taken on a report.
- **Compromised-account indicator** — some signal to a user (or their followers?) that an
  account looks hacked. Nothing decided: what triggers it, who sees it, what it looks like.
- **Groups, Hashtags, Admin Panel** — moved here 2026-09-02 from [[mvp-scope]]'s cut #10, which had
  previously worded it as a permanent cut ("no trigger... not deferred") rather than a deferral.
  Reclassified alongside the other two markers on this list since it's genuinely the same status —
  a name without a plan — not a decision to actually build it. Nothing decided: no scope, no
  schema, no UI, not even whether the three (Groups/Hashtags/Admin) would ship together or
  separately.

**How to apply:** don't build either of these from this note — it deliberately has no "why" or
"how to apply" section because none exists yet. When one gets planned, give it its own file
(`decisions/content-moderation.md`, `decisions/compromised-account-indicator.md` or similar) with
real reasoning, and remove its bullet from this list. Add to [[mvp-scope]]'s ranked cut list only
once it has an actual trigger, not just a name.
