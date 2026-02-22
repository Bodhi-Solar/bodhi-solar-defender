# Bodhi Solar Defender 🌞

A retro arcade game defending the planet from fossil fuel enemies.

**Live at:** [games.bodhi.solar/games/bodhi-solar-defender.html](https://games.bodhi.solar/games/bodhi-solar-defender.html)

---

## Repo Structure

```
bodhi-solar-defender/
├── index.html                          # Redirects to the game
├── CNAME                               # Custom domain config
├── games/
│   └── bodhi-solar-defender.html      # The game (edit SUPABASE config here)
└── README.md
```

---

## Setup Guide

### 1. Supabase — Persistent Leaderboard

1. Go to [supabase.com](https://supabase.com) and create a free account
2. Create a new project (note your project URL and anon key)
3. In the Supabase dashboard, go to **Table Editor → New Table**:
   - Table name: `leaderboard`
   - Columns:
     | Column | Type | Default |
     |--------|------|---------|
     | `id` | `int8` | auto (primary key) |
     | `name` | `varchar` | — |
     | `score` | `int8` | — |
     | `created_at` | `timestamptz` | `now()` |

4. Set **Row Level Security (RLS)** policies in the SQL editor:
```sql
-- Allow anyone to read the leaderboard
CREATE POLICY "Public read" ON leaderboard
  FOR SELECT USING (true);

-- Allow anyone to insert a score
CREATE POLICY "Public insert" ON leaderboard
  FOR INSERT WITH CHECK (true);
```
> Run these in: Supabase Dashboard → SQL Editor → New Query

5. Open `games/bodhi-solar-defender.html` and replace the config values:
```js
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_KEY = 'YOUR_ANON_PUBLIC_KEY';
```
Find these in: Supabase Dashboard → Settings → API

---

### 2. GitHub Pages — Hosting

1. Push this repo to GitHub (public repo)
2. Go to **Settings → Pages**
3. Set source to: **Deploy from branch → main → / (root)**
4. Your game is now live at: `https://yourusername.github.io/bodhi-solar-defender/games/bodhi-solar-defender.html`

---

### 3. Custom Domain — games.bodhi.solar

In **Namecheap** (Advanced DNS for bodhi.solar):

| Type | Host | Value | TTL |
|------|------|-------|-----|
| CNAME | `games` | `yourusername.github.io` | Automatic |

In **GitHub Pages Settings → Custom domain**: enter `games.bodhi.solar` and enable **Enforce HTTPS**.

DNS propagation typically takes 5–30 minutes.

Final URL: `https://games.bodhi.solar/games/bodhi-solar-defender.html`

---

### 4. Prevent Spam / Moderation (Optional)

To avoid bogus scores, consider adding a server-side Supabase Edge Function that validates scores are within a plausible range before inserting. For a fun game leaderboard, the simple public insert policy above is usually fine.

You can review and delete entries anytime in the Supabase Table Editor.
