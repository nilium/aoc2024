#!/usr/bin/env uiua
# Experimental!

Cls ← ◌&runi "clear"

# Flags
~F {f w h t}

# Robots
~R [p v]
# Vectors
~V [x y]

Parse ← ⊜(R∩V ∩₄⋕ °$"p=_,_ v=_,_") ⊸≠@\n

Eval ← ≡⌟(◿⟜+⟜◿:+⊃(R~p|×R~v))

PartOne ← (
  ⊙⊙(⟜(⌊÷₂))
  Eval
  ▽¬◡(≡⌟(/∨=))
  /×⊕⧻ ⊛⤚≡⌟(≤)
)

# Debug function to print an eval'd map of bots.
# Empty spaces are rendered as ., bots as #.
# Unused but left in because it helped find a way to identify a tree.
Print ← (
  Cls
  ⊙⟜(&p $"----- _ -----")
  ⊸Eval
  ⊙(⬚@.↯⊙"")
  ⍜⊡(+@#-@.)
  /$"_\n_"
  &p
)

Found ← (
  ⊃⋅∘⊙⊙∘
  ¬<₁₀₀₀₀ # Hard limit
  ⨬(⊸Eval
    ⍆≡⌟(/+⍜⊡₀×⊙⊢)
    ⧈₂(=₁/-)
    ≤₉/+≡◇(≥₁₂⧻) ⊜□.
  | 0
  )
)

PartTwo ← (
  ⊙(0◌)
  ⍢⊃(∘|⋅+₁|⋅⋅∘) Found
  ⋅⊙◌
)

┌─╴Prog
  Int ← ⌊⋕⊙◌
  # Shorthand for the case/pattern matching of an option.
  # E.g., `O‼! Conf~Field Parser $"--arg=_"`
  O‼! ← ⍩⍜⊙^0^1 °^2

  File ← (
    &p⊸$"=== _ ==="
    ⊙⊃F~t [⊃F~w F~h] Parse &fras
    {⊃PartOne PartTwo}
    ≡(&p $"Part _: _")+₁°⊏
  )

  Call ← (
    # Defaults:
    # f  w  h t
    F {} 101 103 100
    ↘₁&args
    ∧⍣(
      O‼!F~w Int $"-w_"
    | O‼!F~h Int $"-h_"
    | O‼!F~t Int $"-t_"
    | ⍜(⊙(⇌F~f)|⊂))
    ⊸F~f
    ≡⌟File
  )
└─╴

Prog
