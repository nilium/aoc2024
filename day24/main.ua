#!/usr/bin/env uiua
# Experimental!

When‼ ← ⍩(^1) (⍤.^0)

Resolved ← |1 ≠₁⧻
Bits!    ← ⍜∩⋯⬚0^0
Or       ← Bits!∨
And      ← Bits!×
Xor      ← Bits!≠
Eval!    ← |2 ⨬(Or|And|Xor) ⊙(∩^0 ⊙,)°□₃
# TODO: Implement without recursion. Probably sort by number of dependencies
# to cut down on the recursion. For now, memoization keeps it under control
# though.
Resolve ← |2 memo(⨬⊙◌ Eval!Resolve ⊸Resolved °□⊸get)

Op ← ⍣(
  # I highly doubt this is an intended use of case.
  When‼(≍"OR") 0
| When‼(≍"AND") 1
| When‼(≍"XOR") 2
| ⍤.$"Invalid opcode _"
)

┌─╴Parse
  Binding ← ⊜[(⊓□⋕ °$"_: _")] ⊸≠@\n
  Relation ← (
    ⊸≠@\n
    ⊜{(⊙◇Op °$"_ _ _ -> _")}
  )
  Call ← (
    ∩°□ °⊟ ⊜□ ¬⊸⦷"\n\n"
    ⊓Binding Relation
    ⊂⊙≡(⊟⊙□⊃⊣(↻₁↙₃))
    map°⊟⍉
  )
└─╴

# Return results for all keys matching a prefix character (the first argument).
ValuesOf ← (
  :⊙(⊙◌ ⊸°map)
  ⍆▽:⟜≡⌟◇(≍⊢)
  ≡⌟Resolve
)

PartOne ← °⋯ /⊂ ValuesOf @z

PartTwo ← ⋅"unimplemented"

↘1&args
≡(
  Parse &fras
  {⊃PartOne PartTwo}
  ≡(&p$"Part _: _") +₁°⊏
)
