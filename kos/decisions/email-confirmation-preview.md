---
title: email-confirmation-preview
tags: [soc-med-clone, phase-2, auth]
date: 2026-09-02
---

Forward-looking preview of a Phase 2 auth feature — **not MVP, not committed, not being built
now.** Noted here so the approach is decided before it's picked up, same reasoning as
[[two-factor-auth-preview]] and the other parked previews.

**Devise's own `confirmable` module — no extra gem.** Unlike [[two-factor-auth-preview]] (which
needs `devise-two-factor` + `rqrcode`), confirmable ships in Devise core, same as
`recoverable`/`rememberable`/etc. already in for MVP (see [[devise-modules]]). Turning it on means
adding `:confirmable` to the User model's `devise` line and running its migration generator for
`confirmation_token`, `confirmed_at`, `confirmation_sent_at`, and `unconfirmed_email` — same
"don't hand-write the columns, let the gem's generator own them" rule [[data-model-schema]] already
applies to core Devise auth.

**Mailer delivery:** same `letter_opener` setup [[devise-modules]] already uses for `recoverable`
in development — zero infra, zero cost, previews the confirmation email in a browser tab. No
production SMTP decision needed for this note specifically; that's still undecided generally per
[[tech-stack]].

**What the mockups stand in for:** no email is actually sent by a static page — the confirmation
link's `confirmation_token` is fake sample data, same convention `reset-password.html`'s hidden
`reset_password_token` already set for `recoverable`. Two open questions for whoever picks this up:
- Whether `sign_in_after_confirmation` stays Devise's default or gets turned off — decides whether
  confirming logs someone straight in or sends them to `login.html`. The mockup assumes the latter
  (simpler, matches the rest of the auth chain requiring an explicit login step), but this isn't a
  decided requirement.
- Whether login is fully blocked for an unconfirmed account (`confirmation_keys` / access-window
  config) vs. allowed for a grace period — the mockup assumes blocked, since a demo account has no
  reason to ever be in this state, but a real product might want a grace window.

**How to apply:** rank alongside [[mvp-scope]] cut #9 (Email confirmations) — build once this
leaves "portfolio demo" and starts taking real signups from strangers, same trigger
[[devise-modules]] already names.
