---
title: devise-modules
tags: [soc-med-clone, auth]
date: 2026-09-01
---

Which Devise modules are enabled on User, and why — the earlier plan named the gem but never
enumerated this.

**In for MVP:** `database_authenticatable`, `registerable`, `recoverable` (forgot/reset
password), `rememberable`, `validatable`. This is Devise's own default module set — nothing
exotic, no module removed from what `rails generate devise User` gives you out of the box.

**Not in for MVP:** `confirmable` (email-verification-on-signup). Don't confuse this with
`recoverable` above — they're independent Devise modules that happen to both send email.
Confirmable is the "Email Confirmations" line in [[mvp-scope]] cut #8, cut until this takes real
signups from strangers, not a demo. Recoverable shipping now while confirmable waits is
intentional, not an inconsistency.

**Mailer delivery for `recoverable`:** use the `letter_opener` gem in development (previews the
reset email in a browser tab instead of actually sending anything — zero infra, zero cost).
Production SMTP credentials are undecided, same status as deployment generally — see
[[tech-stack]]; whatever's picked must go through Rails encrypted credentials or `.env`, never
hardcoded, per [[implementation-guardrails]].

**How to apply:** `devise :database_authenticatable, :registerable, :recoverable,
:rememberable, :validatable` on the User model — this is the default, so in practice this just
means "don't remove `:recoverable`" rather than adding anything unusual.
