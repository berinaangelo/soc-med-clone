---
title: search-preview
tags: [soc-med-clone, ux, phase-2]
date: 2026-09-02
---

Phase 2 preview for Search — [[mvp-scope]] cut #4, "replaces the User Directory once the user
list is too long to browse. Directory is the deliberate MVP stand-in — see
[[user-directory-entry-point]]." Same status as [[comments-preview]] / [[likes-preview]] /
[[direct-messages-preview]] / [[photo-uploads-preview]] / [[content-visibility-preview]] /
[[two-factor-auth-preview]]: parked, not committed, not part of the MVP build. Now has a UI
mockup — see [search.html](../ux/pages/search.html).

**Separate file, not an in-place edit or back-port — same call as [[photo-uploads-preview]], for
the same reason.** Comments/Likes/Messages added their preview affordance *alongside*
already-committed MVP UI without replacing anything, so they got back-ported straight into the
committed page mockups. Search is different: [[mvp-scope]]'s own language is that it **replaces**
Directory's rail slot and entry-point role, and [[user-directory-entry-point]]/directory.html
remain the actual cited MVP screen. So directory.html stays untouched, and the Directory icon
isn't swapped out anywhere else either — feed.html, profile.html, notifications.html, post.html,
messages.html, and nav.html all still point at directory.html. Only this new search.html shows
the swapped rail slot (self-referential, current-tab-chipped) — the inverse of how
[[direct-messages-preview]]'s mail icon got back-ported everywhere, because that icon added a new
slot instead of replacing an existing one.

**God moment:** same one Directory serves — [[god-moments]] #2, "I Found My People." This screen
exists to be the *better* version of that moment once the list is too long to browse — same job,
less scrolling.

**Icon:** new "search" glyph (Lucide, same 1.75px stroke as the rest of [[iconography]]'s set) —
first search-related icon in the KOS. Rest state matches every other nav item (outline, `w-5 h-5`,
hover surface tint); current-tab state gets the same solid-primary-chip treatment as any other
active nav icon (`w-4 h-4` inside a `p-1.5` `rounded-full` chip, per [[iconography]]'s nav-item
spec) — nothing new invented for the icon's state rule, just [[iconography]] applied to a new
glyph. Also used oversized/`--muted`/no-chip in the pre-search empty state, per [[empty-states]]'s
icon rule.

**Interaction (decided for the mockup only):** live filtering, not a submit button — typing in the
search field filters an in-page list of the same sample people directory.html uses, matching on
name substring, case-insensitive. Three states, all reachable by typing rather than a manual
toggle (the typing itself is the demo):
- **Before typing** — [[empty-states]]'s icon-top/text-below pattern, new copy since this isn't
  one of the three states already named there: search icon, "Find people to follow," "Search by
  name to get started." No CTA — the field right above it already is the action, same reasoning
  directory.html's zero-users edge case used to skip a CTA.
- **Results** — reuses directory.html's card grid exactly (avatar/initials, name, 2-line-clamped
  bio, "View profile →"), nothing re-drawn.
- **No matches** — same empty-state structure, `No one matches "{query}"`, "Try a different name
  or check the spelling." No CTA, same reasoning.

**Not decided yet:** real search semantics (substring vs. fuzzy vs. prefix; name-only or also
bio), debounce/request behavior for a real backend call vs. this mockup's instant client-side
filter, whether Search keeps Directory's public/logged-out reachability or requires login, whether
it replaces the root-path role Directory currently has in [[public-vs-authenticated-pages]]/
nav.html, and pagination/result-cap behavior once a query matches more people than fit on screen
(Directory's own `.limit(9)` cap doesn't obviously transfer to a filtered result set).

**How to apply for now:** [search.html](../ux/pages/search.html) is layout/interaction reference
only. directory.html and [[user-directory-entry-point]] remain the actual MVP entry point until
this is picked up for real.
