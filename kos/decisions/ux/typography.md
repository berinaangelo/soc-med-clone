---
title: typography
tags: [soc-med-clone, ux, identity, typography]
date: 2026-09-01
---

Decided: **Signed Sans** (catalog code 315.3), picked from three typography candidates set
against the [[color-scheme]] plum palette. Full candidate comparison:
[kos/ux/typography.html](../../ux/typography.html).

Sora (display) + Inter (body) + IBM Plex Mono (identity only) — a humanist sans for everything
a person writes, with monospace reserved strictly for handles, timestamps, and follow notices.
Chosen over two runner-ups: 315.1 "Kept Voice" (Fraunces serif + IBM Plex Sans, italic for
bios/captions) and 315.2 "One Family" (Newsreader alone, everywhere, hierarchy from size/weight
only). [[god-moments]] names "I Can't Stop Checking" — a feed people scroll fast, repeatedly —
as one of the two decisive moments; a workhorse sans holds up better than a serif at dense UI
sizes (14–15px handles, timestamps, buttons) in a way finer serif detail doesn't. 315.2 was the
purest structural echo of the palette's single-hue idea but was judged the riskiest bet on
real-screen legibility without a prototype; 315.1 stays a safe fallback if Sans/Inter reads too
generic once built.

The mono-for-identity rule mirrors the palette's own exception: Success/Warning/Danger break the
single hue only for status, never for brand — here, monospace breaks the sans-only rule only for
identity marks (who + when), never for prose.

| Role       | Family        | Weight / style     | Where                                  |
|------------|---------------|---------------------|-----------------------------------------|
| Display    | Sora          | 600                 | Profile names, headings, buttons        |
| Body       | Inter         | 400                 | Posts, bios, feed copy                  |
| Identity   | IBM Plex Mono | 400                 | Handles, timestamps, follow notices only |

**Type scale (decided): Tailwind's default scale, not a custom one.** Per [[tech-stack]]'s
utility-classes-by-default rule, sizes/line-heights/letter-spacing come from Tailwind's built-in
`text-*` steps (each already ships a sensible default line-height) — nothing gets hand-authored
in the Tailwind config, so this never needs revisiting at build time. Pick whichever step
ordinarily fits the element; roughly:

| Role                     | Tailwind                          | Where                              |
|---------------------------|-----------------------------------|--------------------------------------|
| Display, page heading     | `text-2xl`/`text-3xl` `font-semibold` (Sora) | Feed/Directory/Notifications headers |
| Display, profile name     | `text-xl` `font-semibold` (Sora)  | Own profile page                     |
| Display, button label     | `text-sm` `font-semibold` (Sora)  | Buttons                              |
| Body                      | `text-base` (Inter)               | Posts, bios, feed copy               |
| Identity/meta             | `text-sm`/`text-xs` (IBM Plex Mono) | Handles, timestamps, follow notices |

**Font loading (decided): fixed static weights, not a variable font file.** Same Google Fonts
`@family=Sora:wght@...` pattern every specimen doc in `kos/ux/` already uses — already the de
facto choice by precedent across three separate specimens, stated here so it's official rather
than accidental.

See [[color-scheme]] for the palette this pairs with, and [[god-moments]] for the product
context ("I Can't Stop Checking" and "This Is Mine") that shaped the call.
