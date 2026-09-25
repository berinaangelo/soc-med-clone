---
title: photo-uploads-preview
tags: [soc-med-clone, ux, phase-2]
date: 2026-09-02
---

Phase 2 preview for Photo uploads — [[mvp-scope]] cut #3, "replaces the plain-URL
`profile_picture` field, which fails the grandma test (pasting an image URL isn't
zero-instruction) but was kept for MVP build-time budget. Build once that friction is actually
reported, not preemptively." Same status as [[comments-preview]] / [[likes-preview]] /
[[direct-messages-preview]] / [[content-visibility-preview]] / [[two-factor-auth-preview]]:
parked, not committed, not part of the MVP build. Like Comments and Likes (and unlike the other
three), this one now also has a UI mockup — see
[edit-profile-photo-upload.html](../ux/pages/edit-profile-photo-upload.html).

**Deliberately a separate file, not an in-place edit of `edit-profile.html`.** Comments and Likes
added their preview affordance *alongside* already-committed MVP UI on the same pages. Photo
uploads is different: it **replaces** the one field `edit-profile.html` exists to demonstrate, and
that file is the citation [[profile-editing]] and [[data-model-schema]] point to as the MVP
reference (plain-URL `profile_picture`, still the committed field). Overwriting it in place would
leave the MVP decision docs citing a mockup that no longer shows the MVP behavior. So
`edit-profile.html` stays untouched; `edit-profile-photo-upload.html` is a full copy of that
screen with only the picture field swapped, same convention [[direct-messages-preview]] and
[[comments-preview]] used for a wholly new page.

**Schema sketch (framework-agnostic, not yet in [[data-model-schema]]):** drop the
`profile_picture` string column in favor of Active Storage's `has_one_attached :avatar` on User —
Active Storage doesn't add a column to `users` itself, it's the polymorphic
`active_storage_attachments`/`active_storage_blobs` tables plus the model declaration. Named
`avatar` rather than reusing `profile_picture`, since the field is no longer a URL — a fresh name
avoids implying it's still string-typed.

**Icon:** a new "upload" glyph (Lucide, same 1.75px stroke as the rest of [[iconography]]'s set),
first upload-related icon in the KOS — sits inside the dropzone at rest, `--muted`, no chip
(nothing state-worthy to signal until a file is actually attached, same rule [[empty-states]]
already applies to its icons).

**Interaction (decided for the mockup only):** a dropzone — click or drag-and-drop — replaces the
text input entirely when no photo is attached; a photo already on file (or just chosen) instead
shows the existing avatar-circle preview plus two plain-text actions, "Replace photo" and "Remove
photo" (the latter `--danger` on hover, same restrained treatment [[iconography]]'s form-hint rule
already uses — text only, no icon). Matches the mockup-only-interactivity precedent
`edit-profile.html`'s own `updateAvatarPreview()` set: a real file is read locally
(`URL.createObjectURL`) to update the preview and the nav-rail avatar immediately, no fake network
delay simulated.

**Not decided yet:** real content-type/size validation (the mockup's "JPG or PNG, up to 5MB" hint
is an assumption, not a decided limit), whether an uploaded image gets resized/variant-processed
(Active Storage variants need `libvips` or ImageMagick — a new dependency, not evaluated here),
storage backend (local disk vs. S3 — [[tech-stack]] leaves deployment target undecided), what
happens to a user's existing pasted `profile_picture` URL if this ever ships (migrate, ignore, or
force re-upload — not decided), and real upload-progress/error states (the mockup only shows the
instant local-preview swap, not a real multipart upload).

**How to apply for now:**
[edit-profile-photo-upload.html](../ux/pages/edit-profile-photo-upload.html) is the reference for
layout only. Nothing here is committed enough to start building against — same caveat
[[comments-preview]] and [[likes-preview]] carry. `edit-profile.html` and
[[data-model-schema]]'s plain-URL `profile_picture` field remain the actual MVP scope until this
is picked up for real.
