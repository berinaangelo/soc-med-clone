---
title: feed-pagination
tags: [soc-med-clone, ux, scope]
date: 2026-09-01
---

Decided: Feed loads older posts via **infinite scroll**, not numbered pagination — appending
more posts as the user scrolls near the bottom, matching [[god-moments]]'s #5 "I Can't Stop
Checking" (a feed that keeps giving you something, not one that stops you to click "next page").

This is the opposite call from the User Directory, which deliberately has **no pager UI** at all
— see [[user-directory-entry-point]] (hard `.limit(9)`, single page, no "load more" of any kind).
The two pages differ on purpose: Directory is a small, public, one-time browse; Feed is the
personalized, repeatedly-revisited surface the "I Can't Stop Checking" moment is actually about,
so it's the one page in MVP scope where continuous loading earns its complexity.

**Not yet built:** this is a UX note ahead of implementation, not a working mechanism —
[feed.html](../../ux/pages/feed.html) is still a static mockup with a fixed 5-post list (a
"Loading more…" affordance at the bottom marks where this attaches). Build-time mechanics
(Turbo Frames + a `page`/cursor param on the Feed controller action, or a Stimulus scroll-
observer controller triggering a Turbo Stream append) aren't decided yet — pick whichever fits
[[tech-stack]]'s Hotwire-first approach when Feed is actually built, no separate JS pagination
library.

See [[build-order-and-success-criteria]] for where Feed sits in the build sequence this attaches
to once scaffolding starts.
