---
title: empty-states
tags: [soc-med-clone, ux, identity]
date: 2026-09-01
---

Decided: every empty state ([[implementation-guardrails]]'s "fallback on empty states" guardrail)
is a centered column — icon on top, text below, optional single CTA — not a blank page or a bare
`[]`. Structure is fixed; content per state is chosen against [[god-moments]], not generic
"nothing here yet" copy.

**Structure, from already-decided tokens, nothing new invented:**
- Icon: `--muted`, no chip. Signal Weight ([[iconography]]) only fills an icon when something
  true has to be signaled — an empty state is the absence of anything happening yet, so the icon
  stays plain outline, just bigger than its usual UI size to carry the hierarchy on its own.
- Heading: Sora 600, `text-base`/`text-lg` per [[typography]]'s scale.
- Subtext: Inter, `--muted`, `text-sm` — one line, never a paragraph.
- CTA (only where a real next action exists): the same button styling already defined elsewhere,
  not a new component.
- Spacing/corners/motion: [[tech-stack]]'s general rules, nothing state-specific.

**The three states named in [[implementation-guardrails]]:**

| State                    | Icon          | Heading                | Subtext                                              | CTA                     | God moment it opens |
|----------------------------|---------------|--------------------------|---------------------------------------------------------|--------------------------|------------------------|
| Empty feed                 | `i-directory` | "Your feed is quiet"     | "Follow a few people and their posts will show up here." | Browse the directory     | I Found My People       |
| No notifications yet       | `i-bell`      | "No notifications yet"   | "You'll see it here the moment someone follows you."    | none — a wait state, not a dead end | Someone Noticed Me |
| No posts yet (own profile) | `i-compose`   | "Nothing posted yet"     | "Whatever's on your mind, this is the place for it."     | Write your first post    | This Is Mine             |

A fourth case — no posts yet on **someone else's** profile — stays deliberately smaller: no CTA
(there's nothing the viewer can do about it), just `i-profile` and "No posts yet." Not every empty
state earns the full treatment; only the ones the signed-in user can act on do.

**The rule for any future empty state, so this doesn't need re-deciding each time:** name the
[[god-moments]] entry the empty state is standing in front of, then write the CTA as the door to
that moment — not an apology for the page being blank. If there's no real next action, skip the
CTA rather than inventing one; a wait state that's honest about being a wait state ("no
notifications yet") reads better than a button that goes nowhere useful.

See [[iconography]] for the icon rendering rule this reuses, [[typography]] for the type scale,
and [[god-moments]] for the moments each state is written toward.
