#!/usr/bin/env uiua
# Experimental!

Parse ← -@\0 ⊜∘ ⊸≠@\n

Cardinals ← comptime[0_1_0 1_0_1 0_1_0]
Edge      ← ≡(⍜⇌(⊂∞)⊂∞)
Border    ← ⍜⍉Edge Edge

PartOne ← (
  Cardinals # Throw cardinal NSWE directions on the stack.
  Border,   # Surround the map with inf borders.
  ⧈∘ 3_3    # Grab 3x3 cells. (Borders above for edges.)
  # Minor complaint about stencil: can only do multi-dimensional windows with
  # a monadic function, which is kinda tedious.
  # For each 3x3 window, check cardinal elements and see if they're the same as
  # the center. Mask out the other cells. Subtract the number of those from 4
  # and that gets the number of edges. I think I could also do this with rows
  # over coords (e.g., using ⬚∞⊡).
  ⍜/⊂≡⌟(+₄¯/+♭=⊃(⊡1_1)×)
  # Originally used group for this and got the wrong result. Turns out
  # partition works on multidimensional arrays exactly the way you'd want it
  # to, though. So, this can compute the cost of regions per-partition (i.e.,
  # area = length, edges = sum).
  /+𝄈⊜(×⊃⧻/+)
)

PartTwo ← ⋅"unimplemented"

↘₁&args
≡(Parse &fras
  {⊃PartOne PartTwo}
  ≡(&p$"Part _: _")+₁°⊏)
