#!/usr/bin/env uiua
# Experimental!

~Map {Start End Shape Walls}

Parse ← (
  ⊜∘ ⊸≠@\n
  ⍜⇌↘₁ ↘₁
  ≡(⍜⇌↘₁↘₁)
  ⊃(∩(⊢⊚⌕)@S,@E|△|⊚=@#)
  Map
)

┌─╴Move ~ Nav
  Step  ← ⍜°⊟⟜+
  Rot   ← ⨬∘⍜⊡₁¯⊃(=₀⊡₁)↻₁
  Turns ← ⊃⍜⊢Rot ⍜⊢(⍥Rot3)

  Adv     ← [⊃Turns Step]
  Ext     ← ⊃Map~Shape Map~Walls
  Bounded ← /××⊃≥₀>⊣

  Nav ← |2.2 (
    ⊓Adv Ext
    ▽⤚≡⌟Bounded # Select directions that are in bounds.
    ▽¬∊: ≡⊣⟜:
    ↙⧻, [1000 1000 1]
  )
└─╴

Done ← ≍⊓⊣Map~End

P₁ ← ◌⊢ memopathNav Done ⊸[0_1 Map~Start] # Just extract cost. 

P₂ ← (
  memopathNav Done ⊸[0_1 Map~Start]
  ⊙◌ ⧻◴/⊂≡◇≡⊡₁
)

↘₁&args
≡([⊃poolP₁poolP₂] Parse &fras
  ≡(&p$"Part _: _") ⊙wait +₁°⊏)
