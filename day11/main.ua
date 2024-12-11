#!/usr/bin/env uiua
# Experimental!

# Given two arrays, return whether they appear to be the same after sorting.
Equiv ← |2 ≍∩⍆

# Convert an array to a table of counters per row.
Counter ← ≡(⊂:1)
# Parse input as an array of numbers.
Parse ← Counter ⊜⋕⊸≠@ 

Rekey ← memo(
  ↥⊸⊃(
    =0        # Key is 0, select 1.
  | ×2=0◿2⧻°⋕ # Key has an even number of characters, select 2.
  )
  ⨬([×2024]         # Multiply key by 2024.
  | [1]             # Key was 0, return 1.
  | ⍜(°⋕|[⊃↙↘]÷2⊸⧻) # Split the key number in half.
  )
)

# Transform an input key by the rules. Value does not change but may be
# duplicated.
Step ← |1 (
  # Input => [key value]
  # Output => [[key value]] | [[key1 value] [key2 value]]
  °⊟
  # NB: the instructions say "first applicable rule" but neither of the rules
  # with conditions can overlap (0 is an odd number of digits), so it doesn't
  # matter. This obviously isn't the only misleading instruction in day 11.
  Rekey
  ≡⊟⊙¤ # Combine new key(s) with original value.
)

Eval ← |1 (
  []
  ⍢(⊃(⊂: ⊙(Step ⊢)
    | ⋅(↘1)
    )
  | ≠0⋅⧻
  )
  ⊙◌
  ≡◇(⊟⊙/+⊢°⊟⍉) ⊕□ ⊸(⊛⊢⍉)
)

# Apply a number of Eval cycles to an input array of numbers.
Cycle ← ◌⍢(⊃(-1|⋅Eval)|>0)
# Get the number of "stones" that would be returned for a given number of
# cycles and input array.
#
# NB: day 11 instructions state "order is preserved", which is true if you
# implement this as it's described. The instructions don't say that a solution
# has to preserve order, and since we're counting the number of results and
# position has no bearing on rules, just ignore that detail.
Stones ← /+⍜(⍉|⊢↘1) Cycle

PartOne ← Stones 25
PartTwo ← Stones 75

# Bunch of tests to run to validate that step/cycle/stones all work.
Tests ← (
  &p "Running tests..."
  ⍤ ⤙≍[1_123] Step 0_123
  ⍤ ⤙≍[248952_456] Step 123_456
  ⍤ ⤙≍[12_123 1_123] Step 1201_123
  ⍤ ⤙Equiv[253000_1 7_1 1_1] Cycle 1 Counter 125_17
  ⍤ ⤙Equiv[14168_1 2024_1 253_1 0_1] Cycle 2 Counter 125_17
  ⍤ ⤙Equiv[28676032_1 512072_1 24_1 20_1 1_1] Cycle 3 Counter 125_17
  ⍤ ⤙Equiv[6032_1 2867_1 2024_1 512_1 72_1 4_1 2_2 0_1] Cycle 4 Counter 125_17
  ⍤ ⤙Equiv[1036288_1 8096_1 4048_2 67_1 60_1 32_1 28_1 24_1 20_1 7_1 2_1 1_1] Cycle 5 Counter 125_17
  ⍤ ⤙Equiv[2097446912_1 14168_1 4048_1 2024_1 96_1 80_1 48_2 40_2 8_1 7_1 6_2 4_1 3_1 2_4 0_2] Cycle 6 Counter 125_17
  ⍤ ⤙=55312 PartOne Counter 125_17
  ⍤ ⤙=65601038650482 PartTwo Counter 125_17
  &p "Done"
)

¬⊸≍{"--test"}↘1&args
⨬(Tests
| ≡(&fras
    Parse
    [⊃({"Part One" PartOne}
      | {"Part Two" PartTwo})]
    ≡(&p $"_: _" °⊟)
  )
)
