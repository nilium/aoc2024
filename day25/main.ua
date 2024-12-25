#!/usr/bin/env uiua
# Experimental!

# P ← /+♭≡⌟≡⌞(/∨♭>1+) ∩°□°⊟⊕□ ≡(⊃(⊢⊢|∘)) ⊜(⊜(=@#)⊸≠@\n) ¬⊸⦷"\n\n" &fras "input"

~Pat {T Sz}
~Pats {K L}

Parse ← (
  ¬⊸⦷"\n\n"
  ⊜(⊜∘ ⊸≠@\n
    ⊃(=@#⊢⊢|≡(/+=@#)⍉)
    Pat
  )
  ⊕□ ⊸≡Pat~T
  Pats∩(≡Pat~Sz°□)°⊟
)

PartOne ← (
  ⊃Pats~L Pats~K
  ⍆/⊂ ⊞(□₃/×≤₇◡+)
  ▽×⊃(◰|≡(°□⊢)|≡(⍆≡°□↘₁))
  ⧻
)

PartTwo ← (
  ⋅"unimplemented"
)

File ← (
  ⟜(&p$"=== _ ===")
  Parse &fras
  {⊃PartOne PartTwo}
  ≡(&p$"Part _: _")+₁°⊏
)

↘₁&args
≡File
