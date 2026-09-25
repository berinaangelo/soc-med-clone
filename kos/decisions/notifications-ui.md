---
title: notifications-ui
tags: [soc-med-clone, ux]
date: 2026-09-01
---

Notifications get two surfaces, both in MVP: a bell icon (persistent, in the nav) and a
dedicated notifications page (the full list).

**Decided:** both surfaces exist — this isn't an either/or.

**Decided: badge is a dot, not a count.** No unread number on the bell — just a small dot,
reusing the accent-colored dot already established for follow notices in [[typography]]'s
specimen mock. This is separate from [[iconography]]'s Signal Weight chip (the bell's own fill
turning on when it has anything unread) — the dot is the corner marker on top of that, not a
replacement for it.

**Now decided, via the mockup pass** (previously deferred here — updating in place per this file's
own instruction to do so once that pass happened):
- **Read flips on page visit, not per-item click** — mark-all-as-read fires automatically when
  `/notifications` loads. No manual "mark all as read" control exists anywhere.
- **Bell nav placement** — left icon-rail, sticky, shared across every logged-in page. Canonical
  markup lives in [nav component mockup](../ux/components/nav.html); the rail also carries Feed,
  Directory, and the viewer's own avatar.
- **Unread bell rendering** — both signals fire together, not one replacing the other: the solid
  primary chip [[iconography]] names for "unread bell" (same weight as a current-tab icon) *plus*
  the accent corner dot on top of it. Read state is plain outline, no chip, no dot.
- **Notification row layout** — reuses [[typography]]'s specimen "notice" format: leading accent
  dot, actor name, "followed you," mono timestamp. Avatar and name link to the actor's profile
  (Follow itself lives there, not on this page). Built in
  [notifications page mockup](../ux/pages/notifications.html).

Empty-state copy was already decided — see [[empty-states]].

**How to apply:** the two mockups linked above are the reference implementation — build the real
bell icon and `/notifications` page to match them, not from scratch.
