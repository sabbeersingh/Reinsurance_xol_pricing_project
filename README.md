# Excess-of-Loss Reinsurance Pricing: Danish Fire Claims

Prices three excess-of-loss (XoL) layers (5 xs 5, 10 xs 10, 20 xs 20)
from historical claims, using SQL and Excel. All amounts are in millions DKK.

## Data
2,167 Danish industrial fire losses, 1980-1990, from Copenhagen Re
(R package fitdistrplus). Already inflation-adjusted to 1985 values, so no
trending was applied. The smallest claim is 1.0, so small losses are not
in the data.

## Method
1. SQL (SQLite): loaded and checked the data, grouped claims by year, and
   calculated the reinsurer's payment on each claim as
   MIN(MAX(Loss - retention, 0), limit).
2. Excel: calculated claim frequency, average severity to layer,
   burning cost and rate on line for each layer.
   Check: frequency x severity = burning cost.

## Results

| | Layer A (5 xs 5) | Layer B (10 xs 10) | Layer C (20 xs 20) |
|---|---|---|---|
| Avg claims hitting layer per year | 23.09 | 9.91 | 3.27 |
| Avg paid per hitting claim | 3.03 | 5.94 | 10.05 |
| Burning cost (per year) | 69.87 | 58.90 | 32.88 |
| Rate on line | 1,397% | 589% | 164% |

Layers A and B are hit many times a year, so they behave as working
layers. Layer C is hit about 3 times a year, so its burning cost rests on
fewer claims and is more volatile.

## Limitations
- Layers are modelled per occurrence with unlimited reinstatements, so rate
  on line exceeds 100%. Real treaties cap annual recoveries through
  reinstatement terms.
- No claim development or IBNR adjustment
- No exposure or premium data, so no loss ratios or loaded premium
- One reinsurer's data, large industrial fire claims only
- Burning cost is a historical average, not a final price

## Files
- data/: raw claims CSV
- SQL/: database (claims.db) and queries.sql
- excel/: xol_pricing.xlsx with results, pricing table and charts