#!/usr/bin/env uiua
# Experimental!

P  ← ≍⊙⍣↙0⟜⧻
T! ← ⍤⊃$"Want _, got _"^0

~Map {Size Stops}

# Debug map printing. Not very useful with threading.
# Ptr ← ⨬(@v|@>|@^|@<) +⊃(×₂/∨<₀|=₀⊡₀) ⊢
# Debug ← (|2.0
#   memo(/∨∊ □"--debug" &args)
#   ⨬(
#   | ⊙⊃(⬚@.↯ ⊙"" Map~Size) Map~Stops
#     ⊃(Ptr|⊡₁)
#     :⍜(⊙⊡|⊙◌)
#     ⍜(⊡|⊢⬚@# ↯ ⊙"" ⊟1 ⧻)
#     rows&ep
#     &ep ""
#   )
# )

Inputs ← (
  ↘₁&args
  ▽⊸(¬∊ □"--debug")
)

Parse ← (
  ⊜∘ ⊸≠@\n
  ⊙Map ⊃(
    ⊢⊚=@^
  | ♭△
  | ⊚=@#
  )
)

Walled ← /∨∊⊓↘₁Map~Stops
OOB    ← /∨∨⊃<₀≤⊓⊡₁Map~Size

Adv ← ⍜°⊟⟜+
T!≍ [0_¯1 6_3] Adv [0_¯1 6_4]

Rot ← ⨬∘⍜⊡₁¯⊃(=₀⊡₁)↻₁
T!≍ [0_1 1_0 0_¯1 ¯1_0] ≡Rot [¯1_0 0_1 1_0 0_¯1]

Walk ← |2 (
  # ◡Debug
  ⊃⍜⊡₀Rot Adv
  :⊙⤚Walled
  [⨬⋅∘ ⊙◌]
)

Search  ← path(Walk|OOB) ⊟¯1_0
PartOne ← |2 /+◰ ⍜⇌↘₁≡⊡₁ ⊢Search

┌─╴PartTwo
  Check ← =0⧻Search ⊙⍜(⊙Map~Stops|⊂):
  Call ← |2 (
    # Get all walking points from the normal path and use them as stops. Think
    # this might work better if I could keep more state in the node, but the
    # path function terminates if it re-encounters the same node and that might
    # make it harder to terminate.
    ▽⊸◰ ⍜⍉⊡₁⊢ ◡Search
    ⊙⊙¤⊙¤
    # Thread checks since this is still brute force.
    /+wait≡poolCheck
  )
└─╴

Inputs
≡(
  Parse &fras
  {⊃PartOne PartTwo}
  ≡(&p $"Part _: _") +₁°⊏
)
