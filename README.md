# Karl-Anthony Towns 30+ Point Streak Analysis

A Google Cloud Data & AI project analyzing **Karl-Anthony Towns' (KAT) longest streaks of consecutive NBA/BAA regular-season games with 30 or more points**, sorted by the number of consecutive games meeting the scoring criterion.

The project uses **Google Cloud Storage, BigQuery, SQL, and BigQuery Conversational Analytics** to explore KAT's scoring production and efficiency across these streaks.

## Project Architecture

```text
NBA Dataset (CSV)
       ↓
Google Cloud Storage
       ↓
BigQuery External Table
       ↓
BigQuery SQL Analytics
       ↓
BigQuery Visualization
       ↓
BigQuery Conversational Analytics
```

## Overview

The raw dataset is stored in **Google Cloud Storage** and exposed to **BigQuery through an external table**, allowing the source CSV to remain in Cloud Storage while still being queried with SQL.

BigQuery SQL is used to transform the raw statistics into analytical metrics such as points per game, rebounds per game, assists per game, field-goal percentage, three-point percentage, and true shooting percentage.

Finally, **BigQuery Conversational Analytics** provides a natural-language analytics interface over the data, allowing questions about KAT's scoring streaks to be analyzed without manually writing SQL for every question.

## Google Cloud Services

- Google Cloud Storage
- BigQuery
- BigQuery External Tables
- BigQuery SQL
- BigQuery Visualization
- BigQuery Conversational Analytics

## Dataset

The dataset contains 20 records representing Karl-Anthony Towns' longest streaks of consecutive NBA/BAA regular-season games in which he scored **30 or more points**, sorted by the number of consecutive games meeting the criterion.

The data includes:

- Streak length and dates
- Games played
- Points
- Rebounds
- Assists
- Field-goal percentage
- Two-point percentage
- Three-point percentage
- Free-throw percentage
- True shooting percentage
- Game Score
- Box Plus/Minus
- Team

The dataset contains qualifying streaks from KAT's time with both the **Minnesota Timberwolves (MIN)** and **New York Knicks (NYK)**, enabling comparisons of scoring production and efficiency over time.

## SQL Analytics

BigQuery SQL is used to calculate per-game production and shooting-efficiency metrics for each scoring streak.

```sql
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
```

## Conversational Analytics

The BigQuery dataset is connected to **BigQuery Conversational Analytics**, providing a managed natural-language analytics experience grounded in the project data.

Example question:

> Analyze how Karl-Anthony Towns' scoring efficiency changed across his 30+ point streaks over time. Use true shooting percentage, field goal percentage, and three-point percentage, and identify his most efficient streak.

Conversational Analytics interprets the request, analyzes the underlying BigQuery data, summarizes the results, and generates a visualization.

## Architecture Decisions

**Cloud Storage** serves as the raw-data layer, while **BigQuery** provides the analytical layer.

A **BigQuery external table** allows the CSV to remain in Cloud Storage while still being queried using BigQuery SQL. For a larger production workload with frequent queries or more demanding performance requirements, native BigQuery storage could be evaluated instead.

**BigQuery Conversational Analytics** adds a managed natural-language interface over the analytical data, demonstrating how agentic analytics can make structured data more accessible to users who may not write SQL.

## Future Enhancements

Potential extensions include:

- Load the dataset into native BigQuery storage and compare performance with the external table
- Add additional NBA datasets
- Add shot-level coordinate data for traditional basketball shot charts
- Integrate Vertex AI for predictive modeling
- Expand the conversational analytics use cases
