---
title: two-factor-auth-preview
tags: [soc-med-clone, phase-2, auth, security]
date: 2026-09-01
---

Forward-looking preview of a Phase 2 security feature — **not MVP, not committed, not being
built now.** Noted here so the approach is decided before it's picked up, same reasoning as
[[direct-messages-preview]] and [[content-visibility-preview]].

**TOTP only, no SMS OTP.** SMS delivery means an ongoing per-message telephony subscription
(Twilio or similar) — a recurring cost this project explicitly doesn't want, unlike a one-time
build. TOTP (the Google Authenticator / Authy style rotating 6-digit code) is free to run: no
external service, no per-user or per-message charge, and it's the module Devise already has a
first-party answer for.

**Gem: `devise-two-factor`.** Adds `otp_secret`, `consumed_timestep`, and
`otp_required_for_login` columns to User via its own migration generator — same
"don't hand-write the columns, let the gem's generator own them" rule already applied to Devise
core auth in [[data-model-schema]]. QR-code enrollment (scan into an authenticator app) renders
`user.otp_provisioning_uri` via the `rqrcode` gem — no new external dependency beyond that one
small rendering gem.

**Scope for when this is picked up:** enrollment (show QR, confirm one code to turn it on),
require the code on login once enabled, a way to disable it, and backup/recovery codes.

**Update 2026-09-02:** backup codes were originally scoped out here — "a reasonable follow-on but
not required for the initial version, a user who loses their authenticator app and has no backup
codes is a support-contact edge case, not a blocker, for a portfolio-scale app." That reasoning
still holds for *why* it was cut initially, but the mockup pass now covers a backup-codes screen
alongside enrollment/login/disable, so this note no longer reflects the current scope — kept here
as history, not overwritten, same as [[mvp-scope]]'s own revision log. Generate 10 codes on first
enrollment, shown once; a "generate new codes" action invalidates the old set.

**How to apply:** rank alongside [[mvp-scope]] cut #8/#9 (Email confirmations, Groups/Hashtags/
Admin) — build once there are real accounts worth protecting, not preemptively for a demo with
seeded dummy users (see [[seed-data]]).
