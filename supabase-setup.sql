-- ============================================================
-- Bodhi Solar Defender — Supabase Leaderboard Setup
-- Run this in: Supabase Dashboard → SQL Editor → New Query
-- ============================================================

-- 1. Create the leaderboard table
CREATE TABLE IF NOT EXISTS leaderboard (
  id         BIGSERIAL PRIMARY KEY,
  name       VARCHAR(10)  NOT NULL DEFAULT 'ANON',
  score      BIGINT       NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- 2. Index for fast top-10 queries
CREATE INDEX IF NOT EXISTS leaderboard_score_idx ON leaderboard (score DESC);

-- 3. Enable Row Level Security
ALTER TABLE leaderboard ENABLE ROW LEVEL SECURITY;

-- 4. Allow anyone to read scores (public leaderboard)
CREATE POLICY "Public read" ON leaderboard
  FOR SELECT USING (true);

-- 5. Allow anyone to submit a score
CREATE POLICY "Public insert" ON leaderboard
  FOR INSERT WITH CHECK (
    -- Basic sanity check: name not empty, score non-negative
    length(name) > 0 AND score >= 0
  );

-- ============================================================
-- Optional: seed with some starter scores so the board
-- isn't empty on launch day
-- ============================================================
-- INSERT INTO leaderboard (name, score) VALUES
--   ('BODHI', 9500),
--   ('SOLAR', 7200),
--   ('ECO', 5100);
