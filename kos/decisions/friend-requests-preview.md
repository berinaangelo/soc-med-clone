---
title: friend-requests-preview
tags: [soc-med-clone, phase-2, data-model, social-graph]
date: 2026-09-02
---

Forward-looking preview of a Phase 2 social-graph feature — **not built now**, same status as
every other `*-preview.md` file (nothing in this KOS is scaffolded yet — see [PLAN.md](../PLAN.md)).
[[mvp-scope]] cut #6 framed this as a real design fork, not just a "build later" item: "only if
reciprocity actually gets requested; Follow is intentionally asymmetric (Twitter model), not
symmetric (Facebook model), by design, not oversight." That trigger has now fired — decided
2026-09-02, alongside the mockup pass covering it.

**Alongside Follow, not replacing it.** Follow stays exactly as it is today: one-directional, the
Feed's source, the follower/following counts, the thing [[user-directory-entry-point]] exists to
enable. Friend Requests is a second, opt-in, symmetric relationship layered on top — sendable
regardless of whether either side already follows the other. This was a real fork (see this file's
own review) — the alternative was replacing Follow entirely with a Facebook-style single symmetric
relationship — rejected specifically to avoid touching Feed sourcing, follower counts, and
Directory discovery, all of which already work and aren't broken.

**Schema: `FriendRequest`.**

| Field | Type | Notes |
| :--- | :--- | :--- |
| sender_id | bigint (FK → users, indexed) | who sent the request |
| recipient_id | bigint (FK → users, indexed) | who received it |
| status | string/enum | `pending` / `accepted` |

Constraints, mirroring [[data-model-schema]]'s own `Follows` table: unique composite index on
`[sender_id, recipient_id]`, model validation blocking `sender_id == recipient_id` (no
self-request).

**No "declined" status.** Declining a pending request, or the sender canceling one, is a row
delete — not a third status. Re-requesting later just creates a fresh row; no history kept. Same
row-create/destroy-over-boolean-flag simplicity call [[likes-preview]] made for its own toggle.

**Cross-request resolves as accept, not a duplicate.** If B sends a request to A while A already
has a pending request to B, that's B accepting A's existing request (flip that row's status to
`accepted`), not a second `pending` row. App-level check at create time, noted here so it's decided
before build rather than discovered as a bug.

**Notifications gain two action types**, extending [[data-model-schema]]'s single `"follow"`
value — both **info-only**, same shape as an ordinary follow notice, no inline actions on either
row (revised 2026-09-02, see UI section below for why):
- `"friend_request"` — shown to the recipient: "X sent you a friend request." Actioning it happens
  on the dedicated page, not here.
- `"friend_accept"` — shown to the original sender once accepted: "X accepted your friend
  request." The relationship is already settled by the time this renders, so it never had actions
  either way.

**Content visibility.** [[content-visibility-preview]]'s "friends" tier now means an accepted
`FriendRequest` between viewer and author, not computed mutual-follow — see that file's own update
note for the history of why it was computed-only originally.

## UI decisions (via the mockup pass)

**Revised 2026-09-02: a dedicated page + new nav icon, not folded into Notifications.** The
original call was to reuse Notifications entirely (see this file's git history) — reversed once
the user raised a real scaling concern: an actionable Accept/Decline list mixed into the same
stream as passive "X followed you" rows means a popular account's Notifications page floods with
request rows over time, burying the low-frequency FYI notices beneath them. Splitting the surfaces
fixes that: Notifications stays a lightweight, uniform FYI stream (see above — both friend-request
action types are info-only there now, same shape as every other row); the actionable inbox that
has to scale gets a page built for exactly that job, the same reasoning Messages already used for
needing its own surface rather than living inside Notifications.

**New page: [friend requests mockup](../ux/pages/friend-requests.html).** Two sections:
- **Requests** (incoming, pending) — the actionable list, same "notice" row shape as Notifications
  with inline Accept/Decline where the timestamp normally sits. This is the one and only place
  Accept/Decline actually live now — the profile-page "received" state (below) links here instead
  of duplicating the controls.
- **Sent** (outgoing, pending) — same row shape, a single "Cancel" text action instead.

Both sections get their own `empty-states.md`-shaped empty state (icon-top/text-below, no CTA —
same reasoning the Notifications empty state uses, this is a wait state not a dead end).

**New nav icon:** Lucide "user-check" (single person + checkmark) — deliberately not the two-person
glyph Directory already owns in the same rail (would be ambiguous sitting one slot away from it),
and distinct enough from Follow's person-plus icon on the profile-page button. Placed in the rail
between Notifications and Messages — grouped with the god-moment-tied icons (Feed/Directory/
Notifications) rather than after Messages, since an accepted request maps to a god moment and
Messages explicitly doesn't (see its own entry). No unread badge/dot on this icon — same
no-badge precedent Messages already set for a surface that could also grow unboundedly; an open
question if request volume turns out to need one, not decided now.

**Icon reuse elsewhere unchanged:** the existing two-person glyph (Directory/nav, "Friends" in
[privacy settings mockup](../ux/pages/privacy-settings.html)) still means "friends" wherever it
already appears — only the new nav-rail slot needed a different glyph to stay unambiguous next to
Directory's icon.

**Profile-page control, alongside Follow, not replacing its region.** Four mutually exclusive
states (same hidden-for-guest/own-profile gating Follow already has):
1. Not connected — outline "Add friend" button (neutral border/text style, doesn't compete
   visually with Follow's accent fill).
2. Request sent (by viewer) — outline, muted, "Request sent"; clicking cancels it.
3. Request received (from this profile's owner) — a single neutral "Review request" link into
   `friend-requests.html` (revised 2026-09-02 — Accept/Decline no longer duplicated here, see
   above; the dedicated page is the one actionable surface).
4. Friends (accepted) — `--tint-secondary` fill, same treatment as the "Following" button, "Friends"
   label.

**God moment:** a request being *accepted* is a stronger version of [[god-moments]] #1 ("Someone
Noticed Me") — mutual, not one-directional — and is the closest anything in this KOS gets to #4
("I'm Part of Something") without Comments existing yet.

See [[mvp-scope]] cut #6 for the trigger this fires, [[data-model-schema]] for the tables this
extends, [[content-visibility-preview]] for the definition this changes, and [[likes-preview]] for
the row-delete-over-status-flag precedent this reuses.
