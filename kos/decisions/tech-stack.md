---
title: tech-stack
tags: [soc-med-clone, infra]
date: 2026-09-01
---

Backend: Ruby on Rails 8. Frontend: Hotwire (Turbo + Stimulus, server-rendered ERB — no separate
SPA/API layer). Styling: Tailwind CSS (utility classes only — see rule below). Auth: Devise gem.
DB engine: MySQL (`mysql2` gem, pass `rails new --database=mysql`). Testing: Minitest (Rails
default, no extra setup — see [[testing-approach]]).

**Styling changed from Bootstrap 5 to Tailwind CSS.** Bootstrap 5's default component behavior
(dropdowns, modals, etc.) depends on Popper — it doesn't need jQuery in v5, but the project
explicitly ruled out jQuery, and Tailwind avoids the question entirely since it ships no JS
component layer at all; any interactivity is Stimulus, already in the stack. Wire it in via
`tailwindcss-rails` (the official gem, works with Rails 8's default Propshaft/importmap setup,
no separate Node build pipeline needed) rather than a CDN `<script>` tag — the gem gives content-
aware purging in production, a CDN include doesn't.

**Rule:** all UI work uses Tailwind utility classes by default. No hardcoded/custom CSS unless
something genuinely can't be expressed in Tailwind for a specific case — the exception is
per-case, not a standing pattern. Two defaults this implies everywhere, not just icons (see
[[iconography]] for where this was first made explicit):
- **Spacing** — margin and padding use Tailwind's spacing scale utilities (`p-*`, `m-*`, `gap-*`,
  `space-*`), not arbitrary rem/px values.
- **Corners** — rounded by default (`rounded-*`), not sharp/0-radius, on cards, buttons, inputs,
  chips, and any other surface with a corner — square corners are the exception, not the default,
  and need a specific reason if used.
- **Shadows** — flat, no drop shadows anywhere. A surface separates from what's behind it with a
  border (the `--border` token from [[color-scheme]]), not elevation. This was already implicit
  in color-scheme's dark-mode Border row ("no-shadow/flat surfaces need a border... since there's
  no shadow to do it") — stated here explicitly so it isn't missed.
- **Motion** — component-level transitions only: buttons, inputs, cards, and modals get a short
  transition (150ms, `ease`) on their own hover/focus/state changes — the same duration the
  icon chip fill already uses in [[iconography]]. Page navigation itself stays instant — no Turbo
  page-morph/view-transition is enabled, no page-level animation. Wrap every transition in
  `@media (prefers-reduced-motion: reduce)` and drop it for anyone who's asked for less motion.
- **Focus** — every interactive element gets a visible `:focus-visible` state: a 2px solid
  outline in the accent color, 2px offset. Already the convention reused across every specimen
  doc in `kos/ux/`; stated here so it's the app's rule too, not just the docs'.

**Deployment: not decided.** An earlier draft named "Render or Heroku, free tier," but that was
never actually settled and conflicts with the MySQL choice above — Heroku has had no free tier
since Nov 2022, and Render's free managed database offering has historically been Postgres-only,
not MySQL. Dropped from the plan rather than left as a stale placeholder. Doesn't block any of
the build steps in [[build-order-and-success-criteria]]; revisit when it's actually time to
ship, and re-check current free-tier offerings then rather than trusting this note.

**Resolved conflict:** the first plan draft listed Postgres in the tech-stack table but "MySQL
required" in a separate notes section — an internal contradiction that would have left whoever
builds this guessing which one to scaffold with. User's explicit call: MySQL. Both are now
consistent everywhere in this KOS.
