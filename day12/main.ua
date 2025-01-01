#!/usr/bin/env uiua
# Experimental!

Parse ← +₁ -@A ⊜∘ ⊸≠@\n

Cardinals ← comptime[0_1_0 1_0_1 0_1_0]
Border!   ← ⍥(⇌⍉ ⬚^0↯⍜⊢+₁⊸△) 4

PartOne ← (
  Cardinals  # Throw cardinal NSWE directions on the stack.
  Border!∞ , # Surround the map with inf borders.
  ⧈∘ 3_3     # Grab 3x3 cells. (Borders above for edges.)
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

M ← ⍣(
  1 ⍤.≍1_1_1_0
| 1 ⍤.≍1_1_0_1
| 1 ⍤.≍1_0_1_1
| 1 ⍤.≍1_0_1_1
) (0)

# Adjust offsets for a region to surround it with zeros when turning it back
# into a mask. Don't use Border! since we can save a bit by letting unwhere do
# most of the work.
Region ← ⍜⊡⋅0:°⊚⤚⊂+₁⊸/↥ +₁
N      ← /+♭
Diag   ← =₁/+∊[0_1]
# Make sure diag does the right thing.
⍤⟜Diag [0_1 1_0]
⍤⟜Diag [1_0 0_1]
⍤⟜(¬Diag) [1_0 1_0]
⍤⟜(¬Diag) [0_1 0_1]
⍤⟜(¬Diag) [1_1 0_0]
⍤⟜(¬Diag) [0_0 1_1]

Corner  ← ⨬(0|1|×₂Diag|1|0) ⊸N
Corners ← /+♭⧈memoCorner 2_2 Region

# Build a mask of each region and compute the number of cells in it (just the
# length from unpick) and the number of edges by the number of corners. Use
# thread pooling just to speed some of this up because it's really not very
# fast.
PartTwo ← /+wait ⊜pool(×⊃Corners⧻) :°⊡

↘₁&args
≡(Parse &fras
  {⊃PartOne PartTwo}
  ≡(&p$"Part _: _")+₁°⊏)
