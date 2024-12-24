#!/usr/bin/env uiua
# Experimental!

Parse ← ⊜(-@0)⊸≠@\n

Cardinals ← ⊂⊸¯⊟⊸↻₁1_0
Adjacent  ← ▽=⊃(+₁⊡|⤚≡⌟⬚∞⊡ ≡⌟+ Cardinals)
Paths ← (
  ⊃($Start ⊚⌕0|$Goal 9|¤)
  ⊞(□path(Adjacent⊙◌|≍⍜⊙◌⊡))
  ▽⊸◰/◇⊂♭ # Flat array of paths.
)

PartOne ← ⧻▽⊸◰≡[⊃⊢⊣]
PartTwo ← ⧻

↘1&args
≡(
  Paths Parse &fras
  [⊃PartOne PartTwo]
  ≡(&p$"Part _: _") +₁°⊏
)
