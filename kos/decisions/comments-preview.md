---
title: comments-preview
tags: [soc-med-clone, ux, phase-2]
date: 2026-09-02
---

Phase 2 preview for Comments — [[mvp-scope]] cut #1, "closes the 'I'm Part of Something'
god-moment gap." Same status as [[direct-messages-preview]] / [[content-visibility-preview]] /
[[two-factor-auth-preview]]: parked, not committed, not part of the MVP build. Unlike those three,
this one now also has a UI mockup (the others are schema-sketch only) — see
[post mockup](../ux/pages/post.html).

**Schema sketch (framework-agnostic, not yet in [[data-model-schema]]):** a `Comment` — `post_id`,
`user_id`, `body` (required, same 500-char cap as Post, reused rather than inventing a new number),
timestamps. Belongs to both a Post and a User; deleted along with its Post (cascade). No self-notify
equivalent decided yet — whether commenting triggers a Notification is an open question for whenever
this actually gets built, not decided here.

**Entry point — a dedicated post-detail page, not an inline expand-in-Feed:** comments live on their
own page (`post.html` in the mockup), reached by clicking into a post, rather than expanding a thread
directly inside the Feed or Profile post list. Reasoning: [[feed-pagination]]'s Feed is optimized to
stay scannable for [[god-moments]] #5 ("I Can't Stop Checking") — letting every card balloon into a
full comment thread inline works against that. A focused single-post page also gives the composer and
thread room to breathe, the way [[direct-messages-preview]] envisioned a dedicated surface rather than
bolting messaging onto an existing page.

**Not decided yet:** the real route/URL a post detail page would live at, whether Feed/Profile post
cards get a "N comments" affordance linking here (the mockup's Feed/Profile files aren't wired to it
yet — this file exists standalone), and whether comments get their own edit/delete (owner-only, same
guardrail as Posts) — the mockup only shows the empty/populated read states plus the composer.

**How to apply for now:** [post.html](../ux/pages/post.html) is the reference for layout only. Nothing
here is committed enough to start building against — same caveat [[direct-messages-preview]] carries.
