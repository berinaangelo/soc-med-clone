---
title: mockup-guardrails
tags: [soc-med-clone, ux, process]
date: 2026-09-01
---

Process guardrails for building the actual UI mockups (as opposed to the candidate-comparison
specimens already done for [[color-scheme]], [[typography]], and [[iconography]]). Set by the
user ahead of that work starting, so each one can be checked against these before moving to the
next rather than after several have already been built.

**Build one screen/UI at a time, not a full batch.** Stop after each one for a check-in before
starting the next — this is a preemptive gate, not a post-hoc review. Don't get ahead by drafting
several screens in one pass.

**One mockup per screen, not three candidates.** The candidate-comparison format
(color-schemes.html/typography.html/iconography.html style, three options + a verdict) was for
the identity decisions themselves. Now that those are decided, each screen gets a single, final
mockup that applies them — not another round of options.

**Every mockup must actually apply the decided system, nothing re-invented:**
- Color: [[color-scheme]] (Single Thread, hue 315°, light + dark tokens)
- Type: [[typography]] (Sora display / Inter body / IBM Plex Mono identity-only, Tailwind's
  default `text-*` scale)
- Icons: [[iconography]] (Signal Weight — outline at rest, solid chip only for state; Lucide
  geometry, 1.75px stroke)
- Spacing/corners/shadows/motion/focus: [[tech-stack]]'s general Tailwind rules (spacing/rounded
  utilities, no shadows — border separates surfaces, 150ms ease component-only motion, 2px accent
  focus-visible outline)
- Empty states: [[empty-states]] (icon-on-top/text-below, decided copy per state)
- Modals: [[modal-dialog]] (native `<dialog>`, flat panel + scrim, danger-fill confirm)

**Reuse Tailwind utility classes directly in mockup HTML.** Per [[tech-stack]]'s styling rule
(utility classes by default, hand-authored CSS only where something genuinely can't be expressed
in Tailwind) — mockups don't need to hand-roll CSS the way the earlier candidate specimens did.
Custom CSS stays limited to what Tailwind can't express directly: the CSS custom properties for
the palette tokens themselves, font-family declarations, and the couple of native-element
selectors Tailwind has no utility for (`dialog::backdrop`, `:focus-visible`, reduced-motion).
Load Tailwind via the CDN script tag for this kind of exploratory mockup work — no build step
needed at this stage.

**Every mockup gets a UX pass before it's considered done, not just visual polish:**
1. **Grandma test** — could someone with no technical background and no instructions understand
   what the screen is for and what to do on it, just by looking at it? Plain language, one
   obvious primary action, no jargon, no unexplained icons-only controls.
2. **God moment check** — name which entry in [[god-moments]] this screen exists to serve (or
   confirm it's supporting infrastructure that doesn't map to one), and verify the screen actually
   delivers that moment rather than just being functionally correct. A feed that loads is not the
   same as a feed that pulls someone back ("I Can't Stop Checking").

A screen that's visually on-brand but fails either check isn't done — fix it before moving to the
next screen, per the one-at-a-time rule above.

See [[color-scheme]], [[typography]], [[iconography]], [[empty-states]], [[modal-dialog]], and
[[tech-stack]] for the system these mockups apply, and [[god-moments]] for the moments each screen
is checked against.
