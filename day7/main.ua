#!/usr/bin/env uiua
# Experimental!

# This one's fun but there's not a lot to it as far as I can tell. Feels like
# a good break-time puzzle to chill after the last several.

~Input {LHS RHS} # LHS: RHS...

Parse ← (
  ⊸≠@\n
  ⊜(⊸⊗@:
    ⊃(⋕↙
    | ⊜(⋕)⊸≠" "↘+1
    )
    Input
  )
)

Divisible ← =0◿

┌─╴PartOne
  Decompose ← |2 (
    :
    ≠0⊸⧻         # Is the input number set empty?
    ⨬(↥⊃(=0|=1)◌ # Total ended at zero or one.
    | ⊙:°⊂
      ↥⊃(
        ⨬0Decompose ⊃Divisible÷ # Try division.
      | ⨬0Decompose ⊸≥0 -       # Try subtraction.
      )
    )
  )

  Check ← Decompose ⊃(Input~LHS|⇌Input~RHS)

  Call ← |1 (
    ▽≡Check .
    /+≡Input~LHS
  )
└─╴

┌─╴PartTwo
  IsSuffix ← ×⍣(≍↘⊙:-◡∩⧻) 0 ◠(¬≍)
  Chop     ← |2 ⍜(:⇌°⋕|↘⧻°⋕):

  Decompose ← |2 (
    ↧2⧻.: # Is the input number set empty?
    ⨬(0
    | =⊢
    | ⊙:°⊂
      ↥↥⊃(
        ⨬0Decompose ⊃Divisible÷ # Try division.
      | ⨬0Decompose ⊸≥0 -       # Try subtraction.
      | ⨬(0|Decompose Chop) IsSuffix ◡∩°⋕
      )
    )
  )

  Check ← Decompose ⊃(Input~LHS|⇌Input~RHS)

  Call ← (
    ▽≡Check .
    /+≡Input~LHS
  )

  ⍤ $"Want _, got _" ◠=1 Check Input 7290 6_8_6_15
  ⍤ $"Want _, got _" ◠=1 Check Input 292 11_6_16_20
  ⍤ $"Want _, got _" ◠=1 Check Input 156 15_6
  ⍤ $"Want _, got _" ◠=1 Check Input 192 17_8_14
  ⍤ $"Want _, got _" ◠=1 Decompose 11 [11 1]
  ⍤ $"Want _, got _" ◠=1 Decompose 11 [11]
  ⍤ $"Want _, got _" ◠=0 Decompose 0 []

  [Input 7290 6_8_6_15
   Input 292 11_6_16_20]
  ⍤ $"Check rows -- Want _, got _" ◠≍ 1_1 ≡Check
└─╴

↘1&args
≡(Parse &fras
  [⊃({"Part One" PartOne}
    | {"Part Two" PartTwo})
  ]
  ≡(&p $"_: _" °⊟)
)
