#!/usr/bin/env uiua
# Experimental!

┌─╴Parse
  Patterns ← ⊜□¬⊸⦷", "
  Designs  ← ⊜□⊸≠@\n
  Call     ← ?₂⊓Patterns Designs∩°□°⊟⊜□¬⊸⦷"\n\n"
└─╴

PartOne ← /+≡⌞◇(>₀⧻regex) $"^(?:_)+$"/$"_|_"
PartTwo ← (
  ⋅⋅"unimplemented"
)

↘1&args
≡(
  Parse &fras
  {⊃PartOne PartTwo}
  ⍚(&p$"Part _: _")°⊏
)
