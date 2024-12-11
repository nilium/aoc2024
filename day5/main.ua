#!/usr/bin/env uiua
# Experimental!

Inputs    ← ▽¬ ⌕□"--test". ↘1&args
IsTesting ← ≍{"--test"}↘1&args
Expect!   ← |2.0 ⍤:⊙$"Want _, got _" ^0,,

Test‼ ← |0.0 (
  IsTesting
  ⨬(
  | &p $"=== Test - _ ===" ^0
    ≡(&p $"Output => _"){^1}
    &p "-> OK"
  )
)

Lines! ← ⊜^0≠@\n.

┌─╴Data
  Rules    ← °□⊡0
  PageSets ← °□⊡1
└─╴

┌─╴Parse
  Numbers ← |2 (
    :⤙≠ ⊙°□
    ⊜⋕
  )

  Call ← (
    ⊜□ ¬⦷"\n\n".
    °⊟
    {◇Lines!(Numbers @|)
     ⊙◇Lines!(□Numbers @,)
    }
  )
└─╴

┌─╴PartOne
  Middle ← ⊡⌊÷2⧻.

  Matches ← (
    ∩°□°⊟
    :¤
    ≡(:¤°□
      ≡(⍣(∩⊚⊃(⌕⊡1|⌕⊡0)
          <∩⊢
        ) 1
      )
      /×
    )
  )

  Sum ← /+≡◇Middle

  Call ← |1 (
    ⟜Matches
    ▽:°□◌°⊟
    Sum
  )
└─╴

┌─╴PartTwo
  Classify ← (
    ⍣(∩⊚⊃(⌕⊡1|⌕⊡0)
      ≥∩⊢ # 0 if valid, 1 if found but invalid, 0 if miss
    ) 0
  )

  Patch ← |2 (
    ≡(≡(⬚(¯1)⊢⊚⌕)⊙¤),¤,
    ▽¬≡/↥<0
    ◌⍢(
      ⊃(↘1
      | ⊢
        ≡(⊢⊚⌕)⊙(¤.)
        ≥°⊟.
        ⨬(⍜(⊏|↻1)|◌)
      )
    | >0⧻)
  )

  Repair ← |2 (
    ⊏⍜(⍉|⍏⊢).
    =0⧻.
    ⨬(◌⍢(
        ⟜Patch
      | /↥≡Classify ,¤,
      )
    | ◌
    )
  )

  Invalid ← (
    /↥≡Classify ⊙¤
  )

  Call ← (
    ∩(°□)°⊟ # Split up rules (top) and pages (bottom).
    :¤
    /+≡(
      :°□
      Invalid,,

      ⨬(0
      | Repair
        PartOne~Middle
      )
    )
  )

  Test‼(
    "Multi-Rule Patch"
  | 1_2_3_4_5_6_7
    [0_6 2_1 5_4]
    Patch
    Expect!≍ 2_1_3_5_4_6_7
  )

  TestRules ← [
    97_13
    97_61
    97_47
    75_29
    61_13
    75_53
    29_13
    97_29
    53_29
    61_53
    97_53
    61_29
    47_13
    75_47
    97_75
    47_61
    75_61
    47_29
    75_13
    53_13
  ]

  Test‼(
    "Sorting"
  | TestRules
  )

  Test‼(
    "Repair"
  | 75_97_47_61_53
    Repair TestRules
    Expect!≍ 97_75_47_61_53

    61_13_29
    Repair TestRules
    Expect!≍ 61_29_13

    97_13_75_29_47
    Repair TestRules
    Expect!≍ 97_75_47_29_13
  )
└─╴

Test‼(
  "Test Inputs"
| $ 47|53
  $ 97|13
  $ 97|61
  $ 97|47
  $ 75|29
  $ 61|13
  $ 75|53
  $ 29|13
  $ 97|29
  $ 53|29
  $ 61|53
  $ 97|53
  $ 61|29
  $ 47|13
  $ 75|47
  $ 97|75
  $ 47|61
  $ 75|61
  $ 47|29
  $ 75|13
  $ 53|13
  $ 
  $ 75,47,61,53,29
  $ 97,61,53,29,13
  $ 75,29,13
  $ 75,97,47,61,53
  $ 61,13,29
  $ 97,13,75,29,47

  Parse
  [⊃([□"Part One" 143 PartOne]
    | [□"Part Two" 123 PartTwo]
    )]
  ≡(⍤ ⊙= $"_ => want _, got _" ⊙(,,) ⊙°⊟°⊂)
)

# TODO: revisit this and see if I can build something that just determines
# the middle digit by taking all the numbers in the rules, finding out which
# numbers are on the left and right of each number, and then looking for
# whichever number matches a line and taking the middle number based on the
# rule groups. This should hopefully avoid needing to do any of the swapping
# from the brute force approach.

Inputs
≡(Parse &fras
  [⊃({"Part One" PartOne}
    | {"Part Two" PartTwo}
      # | {"Sort" (PartTwo~Repair:◴⊂°⊟⍉.°□⊢)}
    )]
  ≡(&p $"_: _" °⊟)
)
