---
title: direct-messages-preview
tags: [soc-med-clone, phase-2, data-model]
date: 2026-09-01
---

Forward-looking preview of the Phase 2 Direct Messages feature ([[mvp-scope]] cut #5) — **not
MVP, not committed, not being built now.** Noted here only so whoever picks up Phase 2 isn't
designing the shape from scratch, and so it doesn't accidentally get pulled into MVP by
inertia — see the "why not build chat now" reasoning below.

Two new tables:

**Conversations**
| Field | Type | Notes |
| :--- | :--- | :--- |
| user_one_id | bigint (FK → users) | lower user_id of the pair, by convention |
| user_two_id | bigint (FK → users) | higher user_id of the pair |

Unique composite index on `[user_one_id, user_two_id]` — one conversation per pair, no
duplicates. Enforce the "lower id first" ordering in a `before_validation` so `find_or_create`
doesn't create two rows for the same pair.

**Messages**
| Field | Type | Notes |
| :--- | :--- | :--- |
| conversation_id | bigint (FK → conversations, indexed) | `belongs_to :conversation` |
| sender_id | bigint (FK → users) | `validates :sender_id, inclusion: { in: -> (m) { [m.conversation.user_one_id, m.conversation.user_two_id] } }` — sender must be a participant |
| body | text | `validates :body, presence: true, length: { maximum: 1000 }` |
| read | boolean | default: false |

**Implementation notes:**
- Start with polling (Turbo Stream reload on a timer, or plain page refresh) before reaching for
  ActionCable — real-time delivery is a nice-to-have on top of a working inbox, not a
  prerequisite for one.
- Reuse the ownership-check guardrail already in place for Posts (see
  [[implementation-guardrails]]): a `show`/`update` on a conversation must confirm `current_user`
  is one of its two participants.
- Do not let this feature grow a group-chat variant — that's Phase 3 "Groups" territory
  ([[mvp-scope]]) if it ever happens at all.

**Why this stayed out of MVP:** none of the 5 god moments ([[god-moments]]) require private
messaging — it's a second, unrelated feature thread (private 1:1) bolted next to the existing
one (public follow/feed), not a step in that flow. It also doesn't fit the 2-hour build budget —
a Conversation model, a Message model, and some notion of unread state is 45–90 minutes on its
own, more than any single feature already in [[build-order-and-success-criteria]].

**UX/layout — now decided, via the mockup pass (this file was schema-only until now):**

**One page, two panes, not two separate pages.** Conversation list on the left, the selected
thread plus its composer on the right — [messages.html](../ux/pages/messages.html). An inbox
needs its list visible alongside the open thread the way every mainstream email/chat UI works
(Jakob's Law); a single-page split, not a list page linking out to a detail page the way
[[comments-preview]] uses for `post.html`, since a message thread has no independent "detail
page" identity the way a single post does.

**God moment check:** none — [[god-moments]] confirms directly that no entry requires private
messaging. This mockup is supporting infrastructure, the same allowance `nav.html`'s own header
comment claims for itself.

**Nav icon: Lucide "mail," last in the rail.** Placed after Notifications and above the avatar —
the one nav item with no [[god-moments]] tie, so it sits after the three that do rather than
wedged between them. Not `message-circle` — that glyph already belongs to Comments
([[comments-preview]]) and reusing it here would collide. Back-ported in one pass into `nav.html`,
`feed.html`, `directory.html`, `notifications.html`, `profile.html`, and `post.html`, the same
one-shot pattern `nav.html`'s own file history used to fix the bell chip across the four page
mockups that carried it. No unread badge on the nav icon itself in this pass — see "not decided
yet" below.

**Conversation-list row:** avatar, name, mono relative timestamp, truncated preview, and a leading
accent dot for unread — reusing [[notifications-ui]]'s "a dot, not a count" rule, applied per-row
here (each conversation carries its own read state) rather than as a single aggregate on the nav
icon. Selected row: `--surface` background fill plus a `--primary` left border, no shadow, per
[[tech-stack]]'s flat/border-separated surfaces.

**Thread view: plain rows, not chat bubbles.** Reuses the Comments-band row shape verbatim (avatar
+ name/timestamp header + body text, `divide-y`, no shadow) rather than inventing a bubble
component nowhere else decided in this KOS. Authorship is disambiguated by the sender's name label
itself — own messages render as "You" in `--primary` (reusing that token's existing text-color use
in `post.html`'s guest composer) instead of the sender's real name in `--text` — rather than by
position or color alone.

**Composer: 1000-char cap**, not the 500 Posts/Comments use — this schema's `body` validation is
already `maximum: 1000`, and the composer just reflects it rather than reusing the wrong number.

**Empty states — two, treated differently:** an empty inbox (no conversations at all) gets the
full [[empty-states]] treatment with a CTA into the Directory (reusing Feed's exact "Browse the
directory" copy) since a real next action exists. "No conversation selected" — the two-pane
layout's unselected default — does **not** get that treatment: nothing is content-empty, there's
no god moment to open a door to, and the state resolves the instant any row is clicked, so it's a
single muted inline line instead of a full icon/heading/subtext/CTA block.

**Not decided yet:** whether the nav icon itself ever needs an unread indicator (this pass gives
it none — unread state lives per-conversation-row only, not aggregated to the rail), the real
route/URL this page lives at, whether messages are ever paginated/infinite-scrolled within a
thread, whether starting a new conversation has its own entry point beyond "message someone from
their profile" (not built here — the mockup's conversations are all pre-existing), and whether a
conversation ever needs a delete/leave action (parallel to Comments' still-open edit/delete
question).

**How to apply for now:** [messages.html](../ux/pages/messages.html) is the reference for layout
only. Nothing here is committed enough to start building against — same caveat [[comments-preview]]
and [[likes-preview]] carry.
