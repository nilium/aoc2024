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

PartTwo ← (
  °⊟     # Split the rows.
  ⊙¤     # Fix the second row so it can be passed in full for each column of the second row.
  ≡(⟜=   # Take a copy of the number we're searching for and find all instances of it in the second row.
    ×/+: # Swap their positions, sum the count of the number, and multiply it by the count.
  )
  /+ # Sum the resulting counts x*n counts.
)

↘1 &args
≡(&fras
  Parse
  ⊃({"Part One" PartOne}
  | {"Part Two" PartTwo}
  )
  ∩(&p $"_: _" °⊟):
)
