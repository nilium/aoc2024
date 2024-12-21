#!/usr/bin/env uiua
# Experimental!

Parse ← ⊜⋕ ⊸≠@\n

Test ← (
  $ 1
  $ 10
  $ 100
  $ 2024
  Parse
)

P ← ◿₁₆₇₇₇₂₁₆
⍤ ⟜=₁₆₁₁₃₉₂₀ P 100000000
M ← ⍜∩⋯⬚0≠
⍤ ⟜=₃₇ M 15 42

G₁     ← P M ×₆₄.
G₂     ← P M ⌊÷₃₂.
G₃     ← P M ×₂₀₄₈.
Evolve ← G₃G₂G₁

P₁ ← /+wait≡pool(⍥Evolve 2000)
⍤ ⤙=37327623 P₁ Test

P₂ ← ⋅"unimplemented"
# ⍤ ⤙=23 P₂ Test

↘₁&args
≡({⊃P₁P₂} Parse &fras
  ≡(&p$"Part _: _")+₁°⊏)
