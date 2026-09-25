---
title: color-scheme
tags: [soc-med-clone, ux, identity, color]
date: 2026-09-01
---

Decided: **Single Thread**, picked from five color-theory candidates (analogous coral/amber/rose,
complementary indigo/amber, split-complementary teal/magenta/orange, triadic violet/green/orange,
monochromatic plum). Full candidate comparison: [kos/ux/color-schemes.html](../../ux/color-schemes.html).

Monochromatic — one hue (315°, plum/magenta) carried from a near-black shade up to a pale tint,
built entirely from lightness and saturation instead of hue contrast. Chosen because this is a
text-first app — [[god-moments]] names "share what's on your mind" and "feel noticed" as the
two moments that matter, not a loud brand identity, and a single hue keeps every screen from
competing with its own words for attention. Success and danger break the single-hue rule on
purpose: status color has to stay recognizable, not on-brand.

| Role                              | H/S/L         | Hex       | Usage |
|------------------------------------|--------------|-----------|-------|
| Primary (brand, nav, buttons)      | 315° 45% 32% | `#762D64` | header, primary buttons, brand mark |
| Secondary (muted UI, tags)         | 315° 30% 48% | `#9F568D` | secondary UI, tags, avatar fills, secondary text |
| Accent/CTA (follow, notification)  | 315° 72% 46% | `#CA21A0` | "Follow" button, notification badge |
| Success (confirmations)            | 145° 45% 32% | `#2D764B` | saved/confirmed states |
| Warning (pending/held)             | 42° 85% 48%  | `#E2A412` | pending/held states |
| Danger (error, delete)             | 355° 62% 46% | `#BE2D39` | errors, delete, destructive confirm |
| Neutral 900 (text)                 | 315° 12% 15% | `#2B2229` | body text |
| Neutral 500 (muted text)           | 315° 8% 42%  | `#74636F` | secondary text, placeholders |
| Neutral 100 (surface)              | 315° 16% 97% | `#F9F6F8` | cards, inputs |
| Background                         | 315° 10% 98% | `#FAF9FA` | page background |

**Tuned 2026-09-01:** Secondary (56%→48% L) and Success (36%→32% L) both originally cleared only
the 3:1 large/UI-text bar, not the 4.5:1 body-text bar, in one or more of their real uses.
Darkened both, same hue/saturation, until every pairing below clears 4.5:1 outright — no
role in this palette is restricted to large/UI-only text anymore.

**Text-on-accent (decided):** white text on every fill except Warning — Primary (9.01:1),
Secondary (5.01:1, was the one exception before tuning), Accent (4.96:1), Success (5.52:1),
Danger (5.79:1). Warning is the one fill that reads better with dark ink instead (7.01:1 with
Neutral 900 vs. 2.20:1 for white).

**Dark mode (decided):** shipping at launch, same hue/saturation approach as bus-reservation's
palette — same hue (315°) and comparable saturations, lightness inverted for a dark ground
rather than picking new hues. Fill roles (Primary/Secondary/Accent/Success/Warning/Danger) use
the dark theme's own Background value as text, not white — every fill was audited both ways and
Background-as-text won or tied every single one, so one rule covers all six instead of a
per-color exception.

| Role                          | Hex (dark) | vs. light |
|--------------------------------|-----------|-----------|
| Primary                        | `#D369B9` | lighter/brighter for contrast on dark bg |
| Secondary                      | `#CA91BC` | lighter/brighter |
| Accent                         | `#E444BC` | lighter/brighter |
| Success                        | `#59C084` | lighter/brighter |
| Warning                        | `#EFB839` | lighter/brighter |
| Danger                         | `#D4545E` | lighter/brighter |
| Text (was Neutral 900)         | `#EDE9EC` | inverted |
| Muted text (was Neutral 500)   | `#A696A2` | inverted |
| Surface (was Neutral 100)      | `#21181E` | inverted |
| Border                         | `#574252` | new — no-shadow/flat surfaces need a border to separate cards from background since there's no shadow to do it |
| Background                     | `#140F13` | inverted |

**WCAG AA contrast audit (resolved 2026-09-01):** every text/fill pairing actually used in the
design, both themes, computed (relative-luminance formula, not eyeballed) against WCAG AA
(4.5:1 body text, 3:1 large/UI text).

| Pair                                             | Ratio   | Result |
|----------------------------------------------------|--------|--------|
| **Light**                                          |        | |
| Neutral 900 text on Background                     | 14.66:1 | pass, body |
| Neutral 900 text on Neutral 100 surface             | 14.35:1 | pass, body |
| Neutral 500 muted on Background                     | 5.32:1  | pass, body |
| Neutral 500 muted on Neutral 100 surface            | 5.21:1  | pass, body |
| White text on Primary fill                          | 9.01:1  | pass, body |
| White text on Secondary fill                        | 5.01:1  | pass, body |
| White text on Accent fill                           | 4.96:1  | pass, body |
| White text on Success fill                          | 5.52:1  | pass, body |
| Neutral 900 text on Warning fill                    | 7.01:1  | pass, body |
| White text on Danger fill                           | 5.79:1  | pass, body |
| Primary as inline link text on Background           | 8.58:1  | pass, body |
| Secondary as inline link text on Background         | 4.77:1  | pass, body |
| Accent as inline link text on Background            | 4.72:1  | pass, body |
| Success as inline status text on Background         | 5.26:1  | pass, body |
| Danger as inline status text on Background          | 5.52:1  | pass, body |
| **Dark**                                            |        | |
| Text on Background                                  | 15.77:1 | pass, body |
| Text on Surface                                     | 14.39:1 | pass, body |
| Muted on Background                                 | 6.78:1  | pass, body |
| Muted on Surface                                    | 6.18:1  | pass, body |
| Background-color text on Primary fill               | 5.86:1  | pass, body |
| Background-color text on Secondary fill             | 7.48:1  | pass, body |
| Background-color text on Accent fill                | 5.28:1  | pass, body |
| Background-color text on Success fill               | 8.40:1  | pass, body |
| Background-color text on Warning fill               | 10.46:1 | pass, body |
| Background-color text on Danger fill                | 4.72:1  | pass, body |
| Primary as inline link text on Background           | 5.86:1  | pass, body |
| Accent as inline link text on Background            | 5.28:1  | pass, body |
| Border vs. Surface                                  | 1.90:1  | not a text pair, not held to this scale — see follow-up below |

Every pairing above clears the full 4.5:1 body-text bar — after the tuning pass, no role in this
palette is restricted to large/UI-only text. (Ink choices not used above — e.g. dark ink on the
Primary fill, 1.71:1 — were rejected for exactly that reason, not overlooked.)

**Open follow-ups, not blockers:**
- Border contrast in dark mode (`#574252` vs. surface `#21181E`) was tuned for visibility
  (~1.9:1), not WCAG text contrast — borders aren't held to the same standard, but confirm it
  reads clearly once real surfaces/cards are built, not just this swatch.
- Accent and Primary sit only 30° apart in saturation/lightness from each other on the same hue,
  not a different hue — double check the "Follow" button (Accent) still pops clearly against the
  nav bar (Primary) once they're adjacent in a real layout, not stacked in isolated swatches.

See [[mvp-scope]] and [[god-moments]] for the product context this identity serves.
