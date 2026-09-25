# Friendster Rebuild — Plan

Status: planning complete (ruthless-simplicity pass done, run twice), scaffolding not started
(as of 2026-09-01).

## One-sentence scope

A ruthlessly simple, text-first community where you follow people you know, share what's on
your mind, and feel noticed when they respond.

## Primary flow

1. Visitor signs up and creates a profile — name, bio, optional profile picture (a pasted image
   URL, not a file upload — see [[data-model-schema]]).
2. User writes a text post; it shows on their own profile and in the feed of anyone following
   them.
3. User browses the user directory to find people to follow — see
   [[user-directory-entry-point]] for why this exists in MVP at all.
4. User follows/unfollows other users; sees follower/following counts.
5. User's feed shows a reverse-chronological stream of posts from people they follow.
6. User gets a notification when someone follows them.

## Entity model (rough, framework-agnostic)

- **User** — auth columns (`email`, `encrypted_password`, etc.) generated and owned by Devise,
  not hand-written — see [[devise-modules]] for which modules (`recoverable` included for MVP).
  App fields: `name` (required), `bio` (optional), `profile_picture` (optional URL string).
- **Post** — `user_id`, `body` (required, ≤500 chars), timestamps. Editable and deletable by
  its owner only.
- **Follow** — join between two Users: `follower_id`, `followed_id`. Unique on the pair, no
  self-follow — see [[data-model-schema]].
- **Notification** — `recipient_id`, `actor_id`, `action` (MVP only has `"follow"`), `read`.
  Never self-notify.
- **Conversation / Message** — Phase 2, not built yet. Schema already sketched in
  [[direct-messages-preview]] so it isn't designed from scratch when picked up.
- **User (Phase 2 additions)** — `posts_visibility`/`comments_visibility` enums (see
  [[content-visibility-preview]]) and `otp_secret`/`otp_required_for_login` (see
  [[two-factor-auth-preview]]). Neither built yet.

## MVP scope

See [[mvp-scope]] for the full kept/cut breakdown and the ranked post-MVP list. See
[[god-moments]] for the UX moments the plan is optimized around.

## Decisions

- [[tech-stack]] — Rails 8 + Hotwire (Turbo/Stimulus) + Tailwind CSS + MySQL + Devise
- [[data-model-schema]] — Users/Posts/Follows/Notifications field-level detail, constraints,
  Devise-ownership note
- [[user-directory-entry-point]] — why a plain "browse all users" page is in MVP, not Phase 2
- [[direct-messages-preview]] — Conversation/Message schema for Phase 2, parked preview, not
  committed
- [[content-visibility-preview]] — Phase 2 account-level post/comment privacy setting (public/
  friends/only me), parked preview, not committed
- [[public-vs-authenticated-pages]] — which MVP pages require login; root path behavior
- [[devise-modules]] — which Devise modules are enabled (recoverable in, confirmable cut)
- [[two-factor-auth-preview]] — Phase 2 TOTP 2FA, parked preview, not committed
- [[notifications-ui]] — bell icon + solo page both confirmed, details deferred to a UX pass
- [[seed-data]] — dummy demo users so the app isn't empty on first load
- [[implementation-guardrails]] — secrets, ownership checks, strong params, null-safety, empty
  states — constraints on every MVP feature, not separate work
- [[testing-approach]] — Minitest, scope of "well-tested" for a 2-hour MVP
- [[build-order-and-success-criteria]] — the timeboxed build sequence and the definition of done
- [[color-scheme]] — **Single Thread** (monochromatic, hue 315°), chosen from five color-theory
  candidates; light/dark tables + WCAG AA audit

## Next step

**Visual/UX design in progress** for the web app — color scheme decided ([[color-scheme]]);
typography, layout, and mockups still open (the rest of the `decisions/ux/` treatment, same
shape as bus-reservation's) — before `rails new`.

After that: `rails new` + Devise setup, per step 1 of [[build-order-and-success-criteria]].

See [[future-considerations]] for topics named but intentionally not yet planned (content
moderation, compromised-account indicator) — out of scope for both the UX session and the MVP
build, revisit separately.
