#!/usr/bin/env uiua
# Experimental!

Parse ← (
  ≠@\n.  # Get a mask of all non-newline characters so it can be split via partition.
  ⊜(≠@ . # Get a mask of all non-space characters in the line.
    ⊜⋕   # Split the line using the space mask and parse each chunk as a number.
  )
  ⍉ # Transpose the array so each input column is a row.
)

PartOne ← (
  ≡⍆     # Sort both rows.
  /+⌵-°⊟ # Split the rows and take the |delta| between both and sum it.
)

# First pt. two solution just using masking for searches:
PartTwo ← (
  °⊟     # Split the rows.
  ⊙¤     # Fix the second row so it can be passed in full for each column of the second row.
  ≡(⟜=   # Take a copy of the number we're searching for and find all instances of it in the second row.
    ×/+: # Swap their positions, sum the count of the number, and multiply it by the count.
  )
  /+ # Sum the resulting counts x*n counts.
)

# Second pt. two solution using classify:
PartTwoClassify ← (
  °⊟         # Split the rows.
  ∩(⊛.⍆      # Sort the rows and classify them to get unique indices for each row.
    ⊕([⊃⊢⧻]) # Turn both rows into a table of N to N's frequency.
  )

  # Turn the second row into a map of N to its frequency for lookups:
  ⊙(¤map ⊙♭ °⊂ ⍉)

  # Sum each row of the first table with:
  /+≡(
    °⊟     # n1, freq1 := split(row)
    ⟜(:×)  # n1' := n1 * freq1 (keep n1 on top, pull map up)
    ⍣get 0 # freq2 := get(n1, map) else 0
    ×      # freq2 * n1'
  )
)

↘1 &args
≡(&fras
  Parse
  [⊃({"Part One" PartOne}
    | {"Part Two" PartTwo}
    | {"Part Two (Classify)" PartTwoClassify}
    )]
  ≡(&p $"_: _" °⊟)
)
