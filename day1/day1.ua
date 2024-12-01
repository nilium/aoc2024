#!/usr/bin/env uiua
# Experimental!

Parse ← (
  ⍉⊜(⊜⋕≠@ .)?≠@\n.
)

PartOne ← (
  ≡⍆     # Sort both rows.
  /+⌵-°⊟ # Split the rows and take the |delta| between both and sum it.
)

PartTwo ← (
  °⊟     # Split the rows.
  ⊙¤     # Fix the second row so it can be passed in full for each column of the second row.
  ≡(⟜=   # Take a copy of the number we're searching for and find all instances of it in the second row.
    ×/+: # Swap their positions, sum the count of the number, and multiple it by the count.
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
