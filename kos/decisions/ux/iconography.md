---
title: iconography
tags: [soc-med-clone, ux, identity, iconography]
date: 2026-09-01
---

Decided: **Signal Weight** (catalog code 315.5), picked from three icon-rendering candidates set
against the [[color-scheme]] plum palette and [[typography]] type system. Full candidate
comparison: [kos/ux/iconography.html](../../ux/iconography.html).

Outline icons at 1.75px stroke, never filled at rest. A solid fill chip is reserved for state —
it appears only when something true has to be signaled: the nav tab you're on, a notification
you haven't read, a person you already follow, a delete you're about to commit to. Chosen over
two runner-ups: 315.4 "Plain Line" (never fills, any state; color shift only) and 315.6 "Duotone
Plum" (every icon always sits on a tinted chip). This is the third identity decision in a row to
land on the same shape: one restrained default, broken only for meaning, never for decoration —
matching [[color-scheme]]'s Success/Warning/Danger breaking the single hue only for status, and
[[typography]]'s mono breaking the sans-only rule only for identity marks. The bell filling solid
is [[god-moments]]'s "Someone Noticed Me" made visible in the icon itself, not before.

| Role         | Stroke  | Fill rule                        | Where                          |
|--------------|---------|-----------------------------------|----------------------------------|
| Rest         | 1.75px  | none — outline only               | nav, directory, posts, default   |
| Current tab  | 1.75px  | solid chip, primary                | active nav item                  |
| Unread       | 1.75px  | chip, primary tint                 | notification bell                |
| Followed     | 1.75px  | chip, secondary tint               | "Following" button               |
| Destructive  | 1.75px  | chip, danger, on hover — commit needs a separate confirm | delete on a post |

**Icon set (8, matches MVP scope):** feed, directory, notifications, profile, compose, follow,
edit, delete — see [[mvp-scope]] for why each of these and nothing more (no likes/comments icons;
those are Phase 2 per the cut list).

**Icon source (decided): Lucide.** The specimen's technique is one outline icon set restyled by a
CSS chip for state — not two differently-drawn styles swapped in and out. Lucide (the maintained
fork of Feather) matches that directly: a single stroke-based set, round caps/joins, 24×24
viewBox, `stroke-width` overridable per-instance rather than baked into the geometry — set it to
1.75px to match the spec. Several of the specimen's hand-drawn glyphs (directory/users, delete,
edit, bell) already trace Lucide/Feather's own shapes, so the swap should be close to a drop-in.
Heroicons was the runner-up but its "solid" variant is a separately-drawn pictogram set, not the
outline paths filled in — using it for state would mean the icon's shape changing along with its
fill, which isn't the rule 315.5 actually specifies. MIT licensed; per [[tech-stack]]'s no-Node-
build-pipeline rule, vendor just the ~8 needed SVGs as inline partials rather than pulling in the
npm package.

**Chip spacing and corners:** governed by [[tech-stack]]'s general rule (spacing and rounded
corners via Tailwind utilities everywhere, not a per-component choice) — applied here rather than
re-decided. The chip isn't a fixed-pixel circle like the specimen's illustrative CSS — it's an
icon sized with a `w-*`/`h-*` utility, wrapped in padding utilities that scale the chip around it,
with `rounded-full` for the corner treatment (fully rounded, same pill/circle look the specimen
already used, just expressed as a utility instead of an arbitrary radius):

| Context                        | Icon size | Chip padding | Corners       | ≈ total |
|----------------------------------|-----------|---------------|-----------------|---------|
| Grid swatch / hero glyph          | `w-5 h-5` | `p-3.5`       | `rounded-full`  | 48px    |
| Nav item (current-tab chip)       | `w-4 h-4` | `p-1.5`       | `rounded-full`  | 28px    |
| Post-actions (edit/delete)        | `w-5 h-5` | `p-2`         | `rounded-full`  | 36px    |

**Destructive delete (decided): confirm required, chip alone isn't enough.** Hovering/tapping
delete shows the danger chip — that's just the warning affordance the Signal Weight rule already
gives it — but the delete itself only fires after an explicit confirm: a true modal, see
[[modal-dialog]] for the dialog itself. [[god-moments]] names "This Is Mine" as one of the five
moments the product is optimized around — a post disappearing by accident is the opposite of
that, and it's irreversible, unlike everything else delete's chip sits next to (follow/unfollow,
tab switches). One extra step here is worth it precisely because nothing else in this icon set
costs the user anything to get wrong.

**Avatar fallback (decided): circle, initials.** When `profile_picture` ([[data-model-schema]])
is unset, the avatar renders as a circle (`rounded-full`, matching [[tech-stack]]'s corner rule)
filled with `--secondary` and the person's initials in `--on-fill`, Sora 600 — exactly the
treatment already prototyped as `.mock-user .avatar` in the iconography specimen, now the decided
version rather than just a mock fixture. A set `profile_picture` still crops to the same circle;
only the fallback content changes, never the shape.

**Form validation and hints (decided): text below the field, nothing else.** No icon, no border
color change, no toast — an error or a hint (e.g. the post composer's character count) is a
small text line directly under the input: `--danger` for errors, `--muted` for a neutral hint.
Deliberately the least amount of UI that still tells someone what's wrong and how to fix it.

Badge treatment on the bell is also decided — a dot, not a count — see [[notifications-ui]].

See [[color-scheme]] and [[typography]] for the identity this pairs with, [[notifications-ui]]
for the bell's still-open questions, and [[god-moments]] for the product context that shaped the
call.
