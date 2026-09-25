---
title: modal-dialog
tags: [soc-med-clone, ux, identity]
date: 2026-09-01
---

Decided: a **true modal** — the confirm step [[iconography]] requires before a post delete
commits isn't an inline swap or a color change, it's a dialog that takes over interaction until
answered. This is the pattern for any future confirm/dialog need too, not a one-off for delete.

**Built on `<dialog>`, not a hand-rolled overlay.** The native HTML `<dialog>` element gives focus
trapping, ESC-to-close, and a backdrop for free, with no JS library — fits [[tech-stack]]'s
Hotwire-only, no-extra-JS-dependency stance. A small Stimulus controller calls `.showModal()` /
`.close()`; no separate modal framework.

**Look, entirely from already-decided tokens — nothing new invented here:**
- Panel: `--surface` background, `--border` border, `rounded-*` corners — no shadow, per
  [[tech-stack]]'s flat-surfaces rule. The `::backdrop` is a dimmed scrim (`--text` at low
  opacity), which is what separates the panel from the page, not elevation.
- Spacing: Tailwind spacing utilities inside the panel, same as everywhere else.
- Open/close transition: the 150ms `ease` component-motion token from [[tech-stack]], a fade plus
  a small scale-in on the panel and a fade on the backdrop — never a page-level transition.
- Buttons: Cancel is neutral/outline (`--border`, `--text`); the destructive action is a solid
  `--danger` fill with `--on-fill` text, matching how [[color-scheme]] already defines danger
  fills everywhere else.
- Delete-confirm copy: state what's about to happen and that it can't be undone — "Delete this
  post? This can't be undone." — not a generic "Are you sure?"

**Why a full modal and not something lighter:** [[iconography]]'s destructive-delete decision
already established that this one action gets extra friction because it's irreversible and
breaks [[god-moments]]'s "This Is Mine" if it happens by accident. A true modal is the clearest
version of that friction — it can't be dismissed by an accidental second tap the way an inline
toggle could.

See [[iconography]] for the decision this exists to serve, [[tech-stack]] for the tokens/rules it
reuses, and [[god-moments]] for the "This Is Mine" reasoning behind requiring it at all.
