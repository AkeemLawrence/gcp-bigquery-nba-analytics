SELECT
  Rk,
  Team,
  Streak,
  Streak_Started,
  Streak_Ended,
  G,
  ROUND(PTS / G, 1) AS points_per_game,
  ROUND(TRB / G, 1) AS rebounds_per_game,
  ROUND(AST / G, 1) AS assists_per_game,
  ROUND(FG_ * 100, 1) AS fg_pct,
  ROUND(_3P_ * 100, 1) AS three_pct,
  ROUND(TS_ * 100, 1) AS true_shooting_pct,
  GmSc,
  BPM
FROM `inner-nuance-401717.nba_analytics.kat_30pt_streaks`
ORDER BY Streak_Started;
