# Shiptivitas — Feature Ideas to Grow Daily Active Users

> Data context: The Kanban board feature launched Jun 2, 2018.
> Average DAU jumped from **3.63 → 11.79** (+225%) in the months that followed.
> 486 status changes were recorded across 200 cards.
> The most-moved card (Kutch-Mueller) changed status 6 times — showing some users
> actively manage cards through the full backlog → in-progress → complete pipeline.
> The opportunity now is to turn that engaged minority into a daily habit for everyone.

---

## Idea 1 — Card Comments & @Mentions

### Hypothesis
If users can leave threaded comments on cards and @mention teammates, the resulting
notification loop will pull people back to the board daily to read and respond —
turning Shiptivitas from a tool you check occasionally into one you check every morning.

### Expected Impact
**+40–50% DAU.** Social notification loops are the highest-proven driver of daily
retention in B2B tools. Each @mention creates an immediate reason for a second user to
open the app that same day. With 100 users already in the system, even a 20% @mention
rate per card move would generate ~97 extra daily visits per week.

### What the feature is
A comment thread on every card. Users type inline comments on the card detail view.
Typing `@` autocompletes team member names from the `user` table. Mentioned users get:
- An **in-app notification badge** on the bell icon (visible on every page).
- An **email alert** sent immediately.

The board view shows an unread comment count badge on each card so anyone scanning
the columns can see at a glance where conversations are happening.

```
┌──────────────────────────────────────┐
│  Kutch-Mueller     [in-progress] 💬2  │
│  Status changed 6 times              │
└──────────────────────────────────────┘
       ↓ open card ↓
┌──────────────────────────────────────────┐
│  Comments                                │
│  ──────────────────────────────────────  │
│  Sarah  Jun 3  09:12                    │
│  Moved to in-progress. @Mike please     │
│  review the customs docs by EOD.        │
│                                          │
│  Mike  Jun 3  10:45  [NEW]              │
│  On it — will update status by 5pm.     │
│  ──────────────────────────────────────  │
│  [ Add a comment...              Send ] │
└──────────────────────────────────────────┘
```

---

## Idea 2 — Personalised Daily Digest Email

### Hypothesis
If users receive a short morning email showing what changed on the board overnight and
which of their cards need attention, they will open the app daily to act on their
workload — even on days they had no other reason to log in.

### Expected Impact
**+30–35% DAU.** Our data shows DAU plateaued around 11–13 users on weekdays after the
initial launch spike. Email re-engagement is the most reliable way to lift that floor.
B2B digest emails routinely see 45–60% open rates, and a well-timed email converts a
passive user into an active one for that day. Over 30 days this compounds into a 30%+
lift in the monthly active baseline.

### What the feature is
A daily 9am email (user's local timezone) personalised per team member. It contains:

1. **Cards that moved status** since their last login — "Kutch-Mueller moved to Complete
   by Sarah."
2. **Stale cards** they are responsible for that haven't moved in 3+ days.
3. **One-click deep links** — each card name links directly into the app, pre-scrolled
   to that card.

Users can set frequency (daily / weekly / off) in a simple settings page.
No changes to the existing card schema are needed — the digest reads straight from the
`card_change_history` and `login_history` tables that already exist.

```
  Subject: Your Shiptivitas board — 2 updates since yesterday

  Hi Mike,

  ────────────────────────────────────────
  MOVED SINCE YOU LAST LOGGED IN
  ────────────────────────────────────────
  ✅  Kutch-Mueller → Complete   (Sarah, yesterday)
  🔄  Osinski Inc → In-Progress  (Anna, yesterday)

  ────────────────────────────────────────
  NEEDS ATTENTION
  ────────────────────────────────────────
  ⏰  O'Kon Group — stuck in Backlog for 4 days
      [ Open card → ]

  ────────────────────────────────────────
  [ Open board → ]      Unsubscribe
```

---

## Idea 3 — Stuck-Card Nudges & Visual Stale Indicators

### Hypothesis
If users are automatically alerted when a card hasn't changed status in N days, they
will log in to action it — making Shiptivitas a proactive workflow partner that surfaces
problems before they become missed deadlines, rather than a passive board users only
check reactively.

### Expected Impact
**+20–25% DAU** with a secondary impact of **+15–20% card completion rate.** The data
shows 486 status changes across 200 cards — an average of only 2.4 moves per card over
8 months. Many cards are clearly sitting idle. Nudges turn that idle state into a daily
engagement trigger. A higher card completion rate also improves the core value of the
product, driving NPS and word-of-mouth to new freight managers.

### What the feature is
Cards that have not moved status in **3 days** (default; configurable per team) get a
visible "stuck" indicator on the board:

- An **amber left border** on the card tile.
- A small **clock icon** showing how many days it has been stuck (e.g. "⏱ 4d").

Clicking the clock opens a one-action prompt: "Move to In-Progress?" with a confirm
button. Team leads also receive a **weekly Stuck Cards Report** every Monday, listing
all stalled cards with the responsible user's name.

```
  ┌──────────────────────────────────────┐
  ▌  O'Kon Group        [backlog] ⏱ 4d  │  ← amber border
  │  Priority: 3                          │
  └──────────────────────────────────────┘

       ↓ click clock ↓

  ┌──────────────────────────────────────────┐
  │  This card has been in Backlog for 4     │
  │  days. Ready to move it forward?         │
  │                                          │
  │  [ Move to In-Progress ]   [ Dismiss ]   │
  └──────────────────────────────────────────┘
```

---

## Summary

| # | Feature | Core mechanism | Est. DAU lift |
|---|---------|----------------|---------------|
| 1 | Card Comments & @Mentions | Social notification loop | +40–50% |
| 2 | Personalised Daily Digest Email | Email re-engagement | +30–35% |
| 3 | Stuck-Card Nudges | Proactive workflow alerts | +20–25% |

**Recommended shipping order: 3 → 2 → 1.**
Idea 3 is the lowest-effort (reads from existing `card_change_history` with a timestamp
check), delivers immediate value to managers, and creates the data signal (stale cards)
that makes Idea 2's digest emails more useful. Idea 1 requires the most backend work
(new comments table, notification service) but has the highest long-term DAU ceiling.
