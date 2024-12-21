#!/usr/bin/env uiua
# Experimental!

Parse ← ↯∞_3_2⊜⋕×⊃≤₉≥₀-@0.

# 3x3 determinant for fun.
D₃ ← +∩/+¯∩/×∩≡↻¯,,⇡3
⍤⤙=42930 D₃ [10_2_3 4_50_6 7_8_90]
⍤⤙=42930 D₃ ⍉[10_2_3 4_50_6 7_8_90]
⍤⟜=₀ D₃ ↯3_3+₁⇡9
⍤⟜=₀ D₃ ⍉↯3_3+₁⇡9
# 2x2 determinant.
D₂ ← /-⇌/×⍜⊣⇌
⍤⤙=¯2 D₂ [1_2 3_4]
⍤⤙=¯2 D₂ ⍉[1_2 3_4]
⍤⤙=394 D₂ [10_2 3_40]
⍤⤙=394 D₂ ⍉[10_2 3_40]

# NB: See Cramer's rule: https://en.wikipedia.org/wiki/Cramer%27s_rule
# Solve for X.
X ← ÷∩D₂⊙⇌⊃↙₂↘₁
# Solve for Y.
Y ← 𝄈÷∩D₂⊃⍜↻₁↘₁↙₂
# Solve for regular input.
PartOne ← /+♭×3_1⍉▽/↧⍉=⌊.. ≡[⊃X Y]
# Solve for input with ten trillion added to C columns.
PartTwo ← PartOne ≡⍜⊡₂(+10000000000000)

┌─╴Main
  Header  ← &p$"=== _ ==="
  Load    ← Parse &fras
  Parts   ← [⊃PartOne PartTwo]
  Results ← ≡(&p$"Part _: _")+₁°⊏
  File    ← Results Parts Load⟜Header
  Call    ← ≡File
└─╴

Main ↘1&args
