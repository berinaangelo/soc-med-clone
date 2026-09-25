---
title: likes-preview
tags: [soc-med-clone, ux, phase-2]
date: 2026-09-02
---

Phase 2 preview for Likes — [[mvp-scope]] cut #2, "a second, lighter-weight 'Someone Noticed Me'
signal beyond follows; natural pair with Comments, same effort tier." Same status as
[[comments-preview]] / [[direct-messages-preview]] / [[content-visibility-preview]] /
[[two-factor-auth-preview]]: parked, not committed, not part of the MVP build. Like Comments (and
unlike the other three), this one now also has a UI mockup — see [feed](../ux/pages/feed.html),
[profile](../ux/pages/profile.html), and [post](../ux/pages/post.html).

**Schema sketch (framework-agnostic, not yet in [[data-model-schema]]):** a `Like` — `post_id`,
`user_id`, `created_at` only (no `updated_at`; nothing on a like ever changes in place). Belongs
to both a Post and a User, unique composite index on `[post_id, user_id]` (same constraint shape
as [[data-model-schema]]'s Follow unique pair) so a user can't like the same post twice; deleted
along with its Post (cascade), same as Comment. No `liked` boolean column anywhere — a like *is*
the row's existence, not a flag: liking creates the row, unliking destroys it. Reasoning: a
boolean would still need a timestamp alongside it to know *when* someone liked something (for a
future "liked by X and 11 others" read, or a Notification's `created_at`), so the row already
carries everything a flag-plus-timestamp would need in one place — and create/destroy maps
directly onto the toggle interaction itself (one POST, one DELETE), no update action to write or
test.

**Icon/state-color decision:** outline thumbs-up at rest (`--muted` text/icon), matching every
other rest-state icon in [[iconography]] and the way the comment icon next to it never fills
either — picked over a heart, which read as a romantic/dating-app signal rather than this app's
"someone noticed my post" one. Already-liked flips the icon to a solid fill and the text to
`--secondary` — the same two-part signal [[iconography]]'s Followed row already uses for the
"Following" button (chip fill +
`--secondary` text), reused here as the closest existing precedent for "a thing the viewer did is
now true." Deliberately **not** wrapped in [[iconography]]'s padded pill/chip background the way
Followed and the nav/notification icons are: those are all standalone icon-only controls sized as
a chip on their own, but the like affordance sits inline in the same plain-text-link shape the
comment-count affordance already established on the post card — it inherits that shape rather than
inventing a second visual language for the same row. No new CSS custom property needed as a
result — `--secondary` already exists in every mockup file's palette block.

**Layout — same row as the comment-count affordance, not a second line:** the two live in one
`flex items-center gap-4` row, like first then comment count. Reasoning: this is metadata about
the same post, not a second independent affordance competing for space — stacking it as its own
line would add row height to every card in [[feed-pagination]]'s Feed, working against
[[god-moments]] #5 ("I Can't Stop Checking") the same way [[comments-preview]] already reasoned
about for why comments don't expand inline. Like-before-comment ordering follows [[god-moments]]'s
own numbering (#1 "Someone Noticed Me" is the lighter, earlier-hooking moment; #4 "I'm Part of
Something" is the heavier one) — a minor call, easy to flip later.

**Interactive toggle (decided for the mockup only):** unlike the comment-count affordance (a
static link into `post.html`, no click behavior of its own), the like affordance is a real
`<button>` with a small inline click handler that flips its own liked/unliked state and
increments/decrements the shown count — matching the mockup-only toggle pattern this repo already
uses elsewhere (`profile.html`'s `editPost()`, `post.html`'s counter updates). A like is
fundamentally a toggle, not a navigation — a static-only render wouldn't demonstrate the "instant
validation" feeling [[god-moments]] #1 is named for, the way clicking Follow does on
`profile.html`. Static variety (some posts pre-liked, some not, mirroring how comment counts vary
0/1/2/3/5) is used for the *initial* render across cards; the click handler layers on top of that,
not instead of it.

**Click animation:** the icon does a quick 150ms scale pop (1 → 1.25 → 1, `ease`) on every click of
the like button — like and unlike alike — reusing [[tech-stack]]'s existing "component-only,
150ms ease" motion rule rather than inventing a longer one, and wrapped in the same
`prefers-reduced-motion: reduce` guard every other transition in these mockups already uses. It
does not play on a card's initial render (only ever a response to a click), so a post that loads
already-liked shows its solid icon with no animation.

**Not decided yet:** whether liking triggers a Notification (same open question
[[comments-preview]] left for its own self-notify equivalent — not decided here either), the real
route/endpoint a like toggle would hit, whether a post shows *who* liked it ("Liked by X and 11
others") or only a count, whether a post owner can like their own post (profile.html's post cards
are the owner's own — this preview doesn't resolve whether a self-like is even allowed), and
whether comments themselves are ever likeable (out of scope here — this preview only covers liking
a Post).

**How to apply for now:** [feed.html](../ux/pages/feed.html), [profile.html](../ux/pages/profile.html),
and [post.html](../ux/pages/post.html) are the reference for layout only. Nothing here is
committed enough to start building against — same caveat [[comments-preview]] carries.
