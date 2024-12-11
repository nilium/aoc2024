#!/usr/bin/env uiua
# Experimental!

# Use a data definition for ease of unboxing later.
~Form {Shape Groups}

# Parse a map into an array of node positions per each non-dot character.
# The arrays of node positions are boxed inside of the returned array.
Parse ← (
  ⊜∘ ⊸≠@\n       # Split the input by line.
  ×⊙:+1⊸⍜♭⊛ ⤙≠@. # Classify each non-dot item.
  ⸮⊚⊸≠0          # Get an array of the positions of all non-dot items.
  ⸮⤚⊡            # Select the classified IDs of each non-dot item.
  ⊕□ -⊸/↧        # Group the positions by their class IDs.
  △:             # Get the shape of the grid to simplify bounds checks.
  Form
)

PartOne ← (
  ⊸Form~Groups
  ≡◇(
    # For each set of same-class coordinates, run through each combination(2)
    # of coordinates, take the slope of the pair and add/subtract it from each
    # of the two coords to get the antinode coords.
    ⧅< 2
    □≡⍜(°⊟|⊙+ ⤚- ◡-)
  )
  # Join all the antinode coords into a flat array now that their
  # classification isn't needed.
  /◇⊂
  /⊂

  # Filter out coordinates that would fall outside the grid:
  ▽⍜⍉/×≥0.             # Remove <0 points.
  ▽⍜⍉/×<⊙.¤Form~Shape: # Remove points exceeding grid bounds.

  # Bit of code to dump matches as a map.
  # Need to move this to a function later.
  # :⬚@0↯ :"" Form~Shape:
  # ⍢(⊃(↘1
  #   | ⍜(⊡|+1)↙1
  #   )
  # | >0⧻
  # )
  # ≡(?⊚⊸=@0⸮
  #   ⍜(⊡|@.?)
  # )
  # &p⍉
  # # ⊙◌
  ◴
  ⧻ # ⟜&p
)

# TODO: Part 2, find all coords that match the x,y difference of any pair
# of nodes. No idea when I'll get to it.

↘1&args
≡(Parse &fras
  &p PartOne
)
