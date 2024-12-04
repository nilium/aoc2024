#!/usr/bin/env uiua

# Split the input along lines and return it. Because all inputs (test and
# normal) are rectangular, no boxing is done.
Parse ← ⊜∘≠@\n.

# Visual helper grid for diagonals because brain no good:
# ------------------
# 0_0  0_1  0_2  0_3
# 1_0  1_1  1_2  1_3
# 2_0  2_1  2_2  2_3
# 3_0  3_1  3_2  3_3

┌─╴PartOne
  # Look for the strings "XMAS" or "SAMX" in the input and return how many
  # times it was found. It is valid for them to run together (e.g., "XMASAMX").
  IsXmas ← (
    +⊃(⌕"SAMX"|⌕"XMAS")
    /+♭ # Make the array 1D and sum it.
  )

  # Search for the XMAS strings in any of the cardinal directions.
  Cardinals ← (
    # Search the input array and its transpose for the XMAS strings.
    +∩IsXmas ⍉.
  )

  # Return the front diagonal elements of the input (i.e., NW to SE).
  Front ← ⊡[0_0 1_1 2_2 3_3]
  # Return the back diagonal elements of the input (i.e., NE to SW).
  Back ← ⊡[0_3 1_2 2_1 3_0]

  # Search the given 4x4 square for the XMAS strings in diagonal directions.
  Diagonals ← (
    ⊃(Front # Grab the front diagonal
    | Back  # Grab the back diagonal
    )
    +∩IsXmas # Check if either is the string, return 0-2 occurrences.
  )

  Call ← +⊃(
    Cardinals         # Check cardinal directions.
  | ◫4_4              # Break the input into 4x4 (overlapping) windows.
    /+≡(/+≡Diagonals) # Count all diagonal matches in the windows.
  )
└─╴

┌─╴PartTwo
  # Return the front diagonal elements of the input (i.e., NW to SE).
  Front ← ⊡[0_0 1_1 2_2]
  # Return the back diagonal elements of the input (i.e., NE to SW).
  Back ← ⊡[0_2 1_1 2_0]
  
  # Return 1 if the input is either the string "SAM" or "MAS", otherwise 0.
  Valid ← ↥⊃(≍"MAS"|≍"SAM")
  # Return 1 if the input is a 3x3 array with two diagonals that make up "SAM"
  # or "MAS" each.
  IsEcks ← ×∩Valid ⊃(Front|Back)
  
  # Return the total number of matches in the input array that form an X with
  # the strings "MAS" or "SAM".
  Call ← (
    # For each 3x3 window, check that it matches the pattern in IsEcks.
    ◫3_3
    /+≡(/+≡IsEcks)
  )
└─╴

↘1 &args
≡(Parse &fras
  [⊃({"Part One" PartOne}
    | {"Part Two" PartTwo}
    )]
  ≡(&p $"_: _" °⊟)
)
