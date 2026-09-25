# Knowledge Base Index — soc-med-clone

Last updated: 2026-09-02

## Plan
- [PLAN.md](PLAN.md) — one-sentence scope, primary flow, entity model, links to scope/decisions

## Decisions
- [god-moments](decisions/god-moments.md) — the 5 UX moments the plan is optimized around; #4
  ("I'm Part of Something") flagged as not actually delivered by MVP
- [mvp-scope](decisions/mvp-scope.md) — kept vs cut features (ruthless-simplicity pass, revised
  four times — see its Revision history), cut list ranked by post-MVP significance with
  build-trigger for each; Posts now include owner-only edit/delete; cut #6's reciprocity trigger
  fired 2026-09-02, see [[friend-requests-preview]] — still cut/not built, only the design fork
  got resolved; cut #10 (Groups/Hashtags/Admin Panel) reclassified 2026-09-02 from a permanent cut
  to deferred, moved into [[future-considerations]]
- [friend-requests-preview](decisions/friend-requests-preview.md) — Phase 2 preview, cut #6's
  trigger now fired: Friend Requests alongside Follow (not replacing it), `FriendRequest`
  (sender_id/recipient_id/status, unique pair, no self-request, row-delete over a "declined"
  status); `Notification.action` gains `friend_request`/`friend_accept`, both info-only. UI
  revised same day to a **dedicated page** ([friend requests mockup](ux/pages/friend-requests.html))
  + new "user-check" nav icon, after starting out folded into Notifications — reversed once a real
  flooding risk was flagged (an actionable list mixed into the passive follow-notice stream).
  Notifications keeps lightweight FYI rows for both action types; Accept/Decline/Cancel now live
  only on the dedicated page. [profile.html](ux/pages/profile.html) gets a second control region
  alongside Follow, its "received" state linking to the dedicated page rather than duplicating the
  actions
- [tech-stack](decisions/tech-stack.md) — Rails 8 + Hotwire + Tailwind CSS + MySQL + Devise
  (switched from Bootstrap 5 — no jQuery); resolves an earlier Postgres/MySQL contradiction in
  favor of MySQL; deployment target intentionally undecided/dropped, not Render/Heroku as an
  earlier draft assumed; general UI rules also live here — Tailwind spacing/rounded-corner
  utilities, flat/no-shadow surfaces (border does the separation), component-only motion (150ms
  ease, no page transitions), 2px accent focus outline everywhere
- [data-model-schema](decisions/data-model-schema.md) — Users/Posts/Follows/Notifications
  fields, constraints (unique follow pair, no self-follow, no self-notify), Devise-ownership
  note (no hand-written password_digest column)
- [user-directory-entry-point](decisions/user-directory-entry-point.md) — why a plain
  browse-all-users page is in MVP: Follow had no way to find anyone without it; index query
  capped at `.limit(9)` (no pager UI added) since the page is public and unauthenticated
- [direct-messages-preview](decisions/direct-messages-preview.md) — Conversation/Message schema
  for Phase 2, parked preview, not committed, not being built now; now also has a UI mockup
  ([ux/pages/messages.html](ux/pages/messages.html)) and originates the UX/layout decisions the
  schema note never made (two-pane inbox layout, conversation-row/thread-row design, 1000-char
  composer cap, new "mail" nav icon) — see the file's own UX section for the reasoning
- [content-visibility-preview](decisions/content-visibility-preview.md) — Phase 2 account-level
  privacy setting for posts/comments (public/friends/only me); "friends" originally meant mutual
  follow (computed, no new table), updated 2026-09-02 once [[friend-requests-preview]]'s trigger
  fired — now an accepted `FriendRequest`, a real schema addition after all, old reasoning kept as
  history; default `public` preserves MVP behavior
- [public-vs-authenticated-pages](decisions/public-vs-authenticated-pages.md) — profile +
  directory public for MVP, everything else (post CRUD, follow, feed, notifications) requires
  login; root path is Directory when logged out, Feed when logged in
- [devise-modules](decisions/devise-modules.md) — database_authenticatable/registerable/
  recoverable/rememberable/validatable in for MVP (Devise defaults); confirmable stays cut;
  `letter_opener` for local reset-email preview
- [email-confirmation-preview](decisions/email-confirmation-preview.md) — Phase 2 preview for
  `mvp-scope`'s cut #9 (Email confirmations); Devise's own `confirmable` module, no extra gem
  (unlike 2FA), same `letter_opener` mailer setup `recoverable` already uses; two open questions
  flagged for whoever picks this up — `sign_in_after_confirmation` on/off, and whether login is
  fully blocked or grace-windowed for an unconfirmed account; mockup assumes the simpler/stricter
  of each pair
- [two-factor-auth-preview](decisions/two-factor-auth-preview.md) — Phase 2 TOTP 2FA via
  `devise-two-factor` + `rqrcode`, no SMS OTP (avoids a telephony subscription), parked preview
- [comments-preview](decisions/comments-preview.md) — Phase 2 preview for `mvp-scope`'s cut #1
  (Comments); parked/not-committed like the other three previews, but this one also has a UI
  mockup (`ux/pages/post.html`); Comment schema sketch (post_id/user_id/body, 500-char cap reused
  from Post) and the decision to give it a dedicated post-detail page rather than an inline
  expand-in-Feed; several real gaps still open (route, Feed/Profile entry point, comment
  edit/delete) — see the file's "not decided yet" list before building against it
- [likes-preview](decisions/likes-preview.md) — Phase 2 preview for `mvp-scope`'s cut #2 (Likes);
  parked/not-committed like `comments-preview`, its sibling cut at the same effort tier, but this
  one also has a UI mockup (like affordance now on `feed.html`, `profile.html`, and `post.html`);
  `Like` schema sketch (post_id/user_id/created_at, unique per post+user — toggle is row
  create/destroy, no boolean flag) and the icon/state-color call (outline thumbs-up at rest,
  picked over a heart to avoid a dating-app read; solid fill + `--secondary` text when already
  liked, reusing the "Following" button's precedent minus its chip background); notification-
  on-like and self-like both still open — see the file's
  "not decided yet" list
- [photo-uploads-preview](decisions/photo-uploads-preview.md) — Phase 2 preview for
  `mvp-scope`'s cut #3 (Photo uploads); parked/not-committed like `comments-preview` and
  `likes-preview`, its siblings on the same cut list, but unlike them its mockup
  ([ux/pages/edit-profile-photo-upload.html](ux/pages/edit-profile-photo-upload.html)) is a
  standalone copy of `edit-profile.html` rather than an in-place edit, since it *replaces* the
  MVP-committed pasted-URL `profile_picture` field that `edit-profile.html` still needs to
  demonstrate; schema sketch drops that string column for Active Storage's `has_one_attached
  :avatar`; new "upload" icon (first in the KOS), dropzone (click or drag-and-drop) when no photo
  is attached, avatar preview + "Replace photo"/"Remove photo" text actions once one is — real
  validation, variants, storage backend, and URL-to-upload migration all still open, see the
  file's "not decided yet" list
- [notifications-ui](decisions/notifications-ui.md) — bell icon + dedicated page both confirmed
  for MVP; unread state is a solid chip *plus* a corner dot together, not either alone; read flips
  automatically on page visit (no manual control); nav placement, row layout, and empty-state copy
  ([[empty-states]]) all now settled via the mockup pass, no open questions left
- [seed-data](decisions/seed-data.md) — hand-written dummy users/posts/follows in `db/seeds.rb`,
  no Faker needed, so the demo isn't empty on first load
- [implementation-guardrails](decisions/implementation-guardrails.md) — no hardcoded secrets,
  ownership checks beyond login checks, strong params, null-safe current_user, empty-state
  fallbacks — constraints on every MVP feature as it's built
- [testing-approach](decisions/testing-approach.md) — Minitest (zero setup), scope of
  "well-tested" limited to model validations + constraints, not full request/system coverage
- [build-order-and-success-criteria](decisions/build-order-and-success-criteria.md) — the
  timeboxed ~2h45m build sequence and the definition-of-done checklist (no deployment criterion
  for now)

- [future-considerations](decisions/future-considerations.md) — content moderation, a
  compromised-account indicator, and (as of 2026-09-02) Groups/Hashtags/Admin Panel — moved here
  from [[mvp-scope]]'s cut #10, previously worded as a permanent cut rather than a deferral — all
  three named but not yet planned; no scope/schema/trigger decided
- [search-preview](decisions/search-preview.md) — Phase 2 preview for `mvp-scope`'s cut #4
  (Search); parked/not-committed like the other previews, now has a UI mockup
  (`ux/pages/search.html`); replaces Directory's rail slot/entry-point role rather than adding
  alongside it, so — unlike Messages — it's *not* back-ported into any already-committed page's
  rail; directory.html and every other mockup's nav still point at Directory; same god moment as
  Directory (`god-moments` #2, "I Found My People"); new "search" icon; live client-side name
  filter with idle/results/no-match states, no submit button; real search semantics, auth
  requirement, and root-path role all still open — see the file's "not decided yet" list
- [profile-editing](decisions/profile-editing.md) — editing your own profile after signup added
  to MVP scope (was only ever covered at signup); scope is exactly name/bio/profile_picture from
  [[data-model-schema]], nothing Devise-owned; requires login + ownership; entry point is on the
  owner's own profile view
- [mockup-guardrails](decisions/mockup-guardrails.md) — process rules for building the actual UI
  mockups: one screen at a time with a check-in before the next, single final mockup per screen
  (not candidate options), must apply the decided color/type/icon/spacing system, Tailwind
  utilities reused directly instead of hand-rolled CSS, and a grandma-test + god-moment check
  before any screen counts as done

## UX
- [color-scheme](decisions/ux/color-scheme.md) — **Single Thread** (monochromatic, hue 315°)
  chosen from five color-theory candidates; light + dark tables, text-on-fill decisions, WCAG AA
  audit, two flagged non-blockers (Secondary not for body text, Success needs darkening before
  body-sized use); full candidate comparison in [ux/color-schemes.html](ux/color-schemes.html)
- [typography](decisions/ux/typography.md) — **Signed Sans** (315.3): Sora + Inter + IBM Plex
  Mono, mono reserved for handles/timestamps only, never prose; chosen over a Fraunces-serif and
  a single-family option; type scale reuses Tailwind's default `text-*` steps (no custom metrics),
  fixed static font weights; full candidate comparison in [ux/typography.html](ux/typography.html)
- [iconography](decisions/ux/iconography.md) — **Signal Weight** (315.5): outline icons at rest,
  a solid fill chip reserved for state only (current tab, unread bell, followed, destructive
  hover); chosen over a never-fills option and an always-duotone option; icon source is
  **Lucide** (vendored SVGs, stroke-width 1.75px, no npm pipeline); chip sizing/corners via
  [[tech-stack]]'s general Tailwind rule; post delete requires a confirm modal (protects the
  "This Is Mine" god moment, dialog itself in [[modal-dialog]]); avatar fallback is a circle with
  initials; form errors/hints are plain text below the field; full candidate comparison in
  [ux/iconography.html](ux/iconography.html)
- [modal-dialog](decisions/ux/modal-dialog.md) — native `<dialog>` element (focus trap/ESC/backdrop
  for free, no JS library), flat panel + dimmed scrim (no shadow), danger-fill confirm button;
  built for the delete-confirm in [[iconography]] but the general pattern for any future dialog
- [empty-states](decisions/ux/empty-states.md) — centered icon-on-top/text-below pattern for every
  empty state named in [[implementation-guardrails]]; feed/notifications/own-profile each written
  toward the [[god-moments]] entry they open the door to (I Found My People / Someone Noticed Me /
  This Is Mine), not generic "nothing here" copy
- [feed-pagination](decisions/ux/feed-pagination.md) — Feed loads older posts via infinite scroll
  (not numbered pagination), unlike the Directory's deliberate no-pager `.limit(9)`; UX note only,
  Hotwire build mechanics (Turbo Frames/Stream append vs. scroll-observer) not yet decided
- [profile mockup](ux/pages/profile.html) — public profile page (name/bio/picture, follower/
  following counts, posts, Follow control); Follow region and post edit/delete both adapt to
  viewer state (guest, not-following, following, own profile) via a mockup-only toggle; both
  `empty-states.md` profile rows built here for the first time; post delete wired to the decided
  `modal-dialog.md` confirm dialog. Redrawn v2 for section *placement* only (user-supplied
  MySpace-style reference): two-column header (wide identity card + a new "Recent followers" side
  panel, derived from existing Follow data, not a schema addition) and Posts now one banded
  container (label + divided rows) instead of floating cards; every already-decided system rule
  (palette/type/icons/spacing/flat surfaces) carried over unchanged, and the reference's
  non-schema bands (Interests/Music/etc.) were deliberately not built. **Update 2026-09-02:** a
  second control region added next to Follow, per [[friend-requests-preview]] — four states (Add
  friend / Request sent / Review request / Friends) via an independent `friendState` toggle, same
  hidden-for-guest/own-profile gating Follow already had, reusing the two-person icon; the
  "received" state links to [friend-requests.html](ux/pages/friend-requests.html) rather than
  duplicating Accept/Decline here (revised same day, see that file)
- [notifications mockup](ux/pages/notifications.html) — `/notifications` full list, follow alerts
  only (MVP's only notification type); row reuses `typography.md`'s specimen "notice" format
  (accent dot + name + "followed you" + mono timestamp) rather than inventing new row chrome, with
  avatar/name linking to the actor's profile since Follow itself lives there, not on this page; no
  mark-all-as-read button since that flip is decided to happen automatically on page visit; empty
  state is the `empty-states.md` "No notifications yet" wait state, no CTA; other three mockups'
  nav-rail Notifications link now points here instead of `#`. **Update 2026-09-02:** two info-only
  rows added per [[friend-requests-preview]] — "sent you a friend request" and "accepted your
  friend request," both shaped exactly like an ordinary follow notice, no inline actions (a same-
  day revision moved Accept/Decline to the dedicated
  [friend requests mockup](ux/pages/friend-requests.html) once mixing an actionable list into this
  FYI stream was flagged as a flooding risk)
- [friend requests mockup](ux/pages/friend-requests.html) — **Phase 2 preview**, see
  `friend-requests-preview.md`; the actionable inbox for Friend Requests, split out from
  Notifications specifically to scale — two sections, Requests (incoming, pending, inline
  Accept/Decline) and Sent (outgoing, pending, Cancel), both reusing `notifications.html`'s
  "notice" row shape and each with its own `empty-states.md`-shaped empty state. New "user-check"
  nav icon (person + checkmark, distinct from Directory's two-person glyph one slot away), no
  unread badge — same no-badge precedent `messages.html` set. Back-ported into every page mockup
  carrying the persistent rail (`nav.html`, `feed.html`, `directory.html`, `notifications.html`,
  `profile.html`, `post.html`, `messages.html`, `privacy-settings.html`, `security-settings.html`,
  `two-factor-enroll.html`, `two-factor-backup-codes.html`), same convention `messages.html`'s own
  back-port used
- [nav component mockup](ux/components/nav.html) — the persistent left icon-rail as its own
  component, not a route; fixes the bell across all four page mockups to show the solid unread
  chip *and* the corner dot together (only the dot had shipped before); demonstrates root-path
  session switching (Directory logged-out ↔ Feed logged-in) via a session toggle — no wordmark/home
  icon invented, since none is decided anywhere in the KOS; `notifications-ui.md` updated in place
  now that this closes out every open question it had deferred. Carries the "Friend requests" icon
  too as of 2026-09-02, same as every other rail-bearing mockup
- [post + comments mockup](ux/pages/post.html) — **Phase 2 preview**, see `comments-preview.md`;
  single-post detail page (Priya's golden-hour post, reused from `feed.html`), a comment composer
  (Feed's composer shape, 500-char cap, hidden for guests in favor of a log-in prompt), and a
  Comments band reusing `profile.html`'s banded/divided-rows pattern; new "No comments yet" empty
  state (no CTA — the composer above already is one) and a new comment/message-circle icon, the
  first of either kind in the KOS. Every post card in `feed.html` and `profile.html` now has a
  matching comment-count affordance (same icon, "N comments"); only Priya's golden-hour post links
  to `post.html` for real (the one post with a matching detail page) — every other post uses a `#`
  placeholder rather than pointing at mismatched content, same convention as
  `notifications.html`'s avatar links. A like affordance (outline/filled thumbs-up + count,
  click-toggleable) was added in a later pass across the same three files per `likes-preview.md`
  — see that file for the icon-fill/state-color decision
- [messages mockup](ux/pages/messages.html) — **Phase 2 preview**, see
  `direct-messages-preview.md`; single-page two-pane inbox (conversation list left, selected
  thread + composer right) rather than two separate pages, since a live thread needs its list
  visible alongside it. God-moment check: none — `direct-messages-preview.md` confirms directly
  that no `god-moments.md` entry requires private messaging, so this is supporting infrastructure,
  the same allowance `nav.html`'s own header comment claims. Adds a new nav icon (Lucide "mail,"
  last in the rail, above the avatar) since `message-circle` is already spoken for by Comments —
  back-ported in the same pass into `nav.html`, `feed.html`, `directory.html`,
  `notifications.html`, `profile.html`, and `post.html`, mirroring how `nav.html`'s own entry
  notes it "fixes the bell across all four page mockups." Reuses `post.html`'s Comments-band row
  shape for both the conversation list and the thread view (plain rows, no chat bubbles — nothing
  re-invented) and `notifications-ui.md`'s accent-dot unread rule, applied per-conversation-row
  instead of only on the nav bell; composer reuses `post.html`'s composer shape but with a
  1000-char cap (the schema's real limit, not the 500 Posts/Comments share). Two empty states:
  full `empty-states.md` treatment for an empty inbox (CTA into `directory.html`, reusing
  `feed.html`'s exact copy) and a deliberately lighter inline placeholder for "no conversation
  selected" (not a content-empty state, no god moment behind it, resolves on first click).
  Mockup-only script: `selectConversation()` populates the right pane / marks the row selected /
  clears its unread dot, `updateMessageCounter()` for the 1000-char composer, and
  `toggleEmptyInbox()` matching the "preview empty state" convention every other list mockup uses
- [edit-profile photo-upload mockup](ux/pages/edit-profile-photo-upload.html) — **Phase 2
  preview**, see `photo-uploads-preview.md`; a standalone copy of `edit-profile.html` with only
  the profile-picture field swapped — a dropzone (click or drag-and-drop, new "upload" icon)
  replaces the pasted-URL input when no photo is attached, and an avatar preview + "Replace
  photo"/"Remove photo" text actions replace it once one is, mirroring the field's own preview/
  fallback behavior from `edit-profile.html`. On-screen preview banner marks it not-committed so
  it isn't mistaken for the real MVP screen sitting next to it. Mockup-only script reads a real
  local file via `URL.createObjectURL` for the preview and nav-rail avatar — no fake upload
  progress simulated, per the preview note's "not decided yet" list
- [search mockup](ux/pages/search.html) — **Phase 2 preview**, see `search-preview.md`; a wholly
  new page (not an edit of `directory.html`) since Search *replaces* Directory's rail slot rather
  than adding alongside it — same non-back-port treatment `photo-uploads-preview.md` used for the
  same reason. Search field + card grid reusing `directory.html`'s cards exactly; mockup-only
  `filterPeople()` live-filters the sample people by name substring and switches between three
  states (pre-search prompt, results, no-match), all three new `empty-states.md`-shaped copy since
  none of them are the file's three already-named rows. New "search" icon (current-tab chip on
  this page only). On-screen preview banner marks it not-committed, same convention as the
  photo-upload preview
- [privacy settings mockup](ux/pages/privacy-settings.html) — **Phase 2 preview**, see
  `content-visibility-preview.md`; a wholly new page (no Settings/privacy screen existed before),
  deliberately not folded into `edit-profile.html` since `profile-editing.md` scoped that screen to
  exactly name/bio/profile_picture. Introduces the KOS's first radio-card selector component,
  applying `iconography.md`'s Signal Weight rule as-is (selected option's icon in a solid
  `--primary` chip, unselected stay outline) rather than inventing new selection chrome; "Friends"
  reuses the existing two-person glyph, "Public" (globe) and "Only me" (lock) are the KOS's first
  of each. Two fields: posts-visibility fully interactive with `public` selected by default
  (matches the decided MVP-preserving default), comments-visibility shown but disabled/grayed with
  a plain-language hint ("Comments hasn't shipped yet…") since Comments itself is still a parked
  cut. God-moment check: none of `god-moments.md`'s 5 entries — supporting infrastructure, same
  allowance already used for `messages.html`. Entry-point wiring (a link from `profile.html`/
  `edit-profile.html`) is left open, not built in this pass, per `mockup-guardrails.md`'s
  one-screen-at-a-time rule.
- [security settings mockup](ux/pages/security-settings.html) — **Phase 2 preview**, see
  `two-factor-auth-preview.md`; second account-management hub, same shell/pattern as
  `privacy-settings.html`. Status row toggles (mockup-only) between off (one-line explainer + "Turn
  on" → `two-factor-enroll.html`) and on (`--success`-dot status, "View backup codes" →
  `two-factor-backup-codes.html`, "Turn off" → a danger-fill confirm `<dialog>` built on
  `modal-dialog.md`'s exact pattern, reused byte-for-byte from `profile.html`'s delete-confirm).
  God-moment check: none — supporting infrastructure, same allowance as `messages.html`.
  Entry-point wiring from `profile.html`/`edit-profile.html` left open, same convention
  `privacy-settings.html` used.
- [two-factor enrollment mockup](ux/pages/two-factor-enroll.html) — **Phase 2 preview**, reached
  from `security-settings.html`'s off state. Hand-drawn QR placeholder (finder-pattern corners +
  fixed module grid, always black-on-white regardless of site theme like a real authenticator
  app's own image — NOT a real/scannable code, `rqrcode` isn't running in a static mockup) plus a
  manual-entry secret fallback (`<details>` disclosure, sample Base32 key) and a 6-digit confirm
  input. Both render in Tailwind's default `font-mono` stack rather than loading IBM Plex Mono,
  which stays reserved for handles/timestamps per `typography.md`. Confirming continues to
  `two-factor-backup-codes.html?context=enrolled` — that's the real moment codes get generated.
- [two-factor backup codes mockup](ux/pages/two-factor-backup-codes.html) — **Phase 2 preview**;
  one file serving two contexts via `?context=` (mockup-only, no real routing needed): fresh from
  enrollment ("Save your backup codes now", all 10 unused) or revisited from
  `security-settings.html`'s "View backup codes" (neutral framing, 2 of the 10 sample codes shown
  struck-through as already used — demonstrates the once-only rule concretely instead of only
  stating it). "Generate new codes" opens a second danger-fill confirm dialog, same
  `modal-dialog.md` pattern as `security-settings.html`'s turn-off dialog.
- [login mockup](ux/pages/login.html) — updated in place to add a mockup-only step 2 (`two-factor-
  auth-preview.md`): a "Preview: this account has 2FA enabled" toggle (same convention as
  `search.html`'s logged-in preview) swaps the existing step-1 card (untouched MVP markup) for a
  6-digit code step with a "Use a backup code instead" fallback that reshapes the same input/copy
  in place, and a "Back" link. Same minimal-fields, no-extra-chrome ethos step 1's own god-moment
  comment already states. **Updated again** for `email-confirmation-preview.md`: a second toggle,
  "Preview: this account is unconfirmed," alongside the 2FA one — since Devise's `confirmable`
  fails sign-in with a flash error rather than a second step (unlike 2FA), this just reveals the
  password field's existing danger-text error-span convention plus an adjacent "Resend
  confirmation email" link, no new step/div needed.
- [check-your-email mockup](ux/pages/email-confirmation-sent.html) — **Phase 2 preview**, see
  `email-confirmation-preview.md`; the pending state reached from `signup.html`'s submit once
  Devise's `confirmable` module holds a fresh account until its emailed link is clicked. Same
  auth-chain shell as `signup.html`/`login.html`/`forgot-password.html` (centered card, no nav
  rail — visitor isn't authenticated yet), new mail icon reusing the existing Messages nav SVG's
  geometry in a plain circle, "Resend confirmation email" action with nowhere to submit (mockup
  only, no email actually sent). Entry-point wiring from `signup.html` is left open this pass, same
  convention `privacy-settings.html`/`security-settings.html` used for their own open wiring, per
  `mockup-guardrails.md`'s one-screen-at-a-time rule.
- [confirm-email mockup](ux/pages/confirm-email.html) — **Phase 2 preview**, see
  `email-confirmation-preview.md`; the page the emailed confirmation link lands on, counterpart to
  `email-confirmation-sent.html`. Hidden `confirmation_token` field mirrors `reset-password.html`'s
  hidden `reset_password_token`. One file, two contexts via `?context=` (mockup-only, same
  mechanism as `two-factor-backup-codes.html`): default/`?context=success` — `--success`-toned
  circle-check icon, "Email confirmed", CTA to `login.html`; `?context=expired` — `--danger`-toned
  circle-x icon, "This link has expired", single email field + "Resend confirmation email" button
  reusing `forgot-password.html`'s single-field form shape. Same preview banner and centered-card
  shell as `email-confirmation-sent.html`. God-moment check: none — supporting infrastructure,
  same allowance as the rest of the auth chain.

## Reference

(none yet)
