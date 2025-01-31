#!/usr/bin/env uiua
# Experimental!

~VM {PC Out Reg Code}

Xor    ← ⍜∩⋯⬚0≠
Prefix ← ≍⊙⍣↙0⟜⧻
Suffix ← Prefix∩⇌

┌─╴Eval
  Reset ← ⍜VM~Out⋅[] ⍜⊙VM~Reg[⊙(0 0 ◌)]

  ┌─╴Step
    A ← ⊡0 VM~Reg
    B ← ⊡1 VM~Reg
    C ← ⊡2 VM~Reg

    Fwd     ← ⍜VM~PC +₂
    Arg     ← ⨬(0|1|2|3|A|B|C)
    Code    ← °⊟⊏[⟜+₁]⊃VM~PC VM~Code
    ArgDesc ← ⨬(0|1|2|3|"$A"|"$B"|"$C")

    Debug‼ ← &ep$"_\t:: @_\t$A=_\t$B=_\t$C=_\t=> _"⊙⊸⊃(VM~PC|A|B|C|VM~Out) ^1 ◠(^0)

    Adv ← Fwd ⍜(⊙A|⌊÷)ⁿ:2 ⊸Arg
    Bxl ← Fwd ⍜⊙B Xor
    Bst ← Fwd ⍜(⊙B|◿₈⊙◌) ⊸Arg
    Jnz ← ⨬(⋅Fwd|⍜⊙VM~PC⊙◌) ≠₀ A,
    Bxc ← Fwd ⍜⊙B Xor ⊸C ◌
    Out ← Fwd ⍜(⊙VM~Out|⊂:) ◿₈ ⊸Arg
    Bdv ← Fwd ⍜⊙B⊙◌ ⌊÷:A,ⁿ:2 ⊸Arg
    Cdv ← Fwd ⍜⊙C⊙◌ ⌊÷:A,ⁿ:2 ⊸Arg

    Call ← ⨬(Adv|Bxl|Bst|Jnz|Bxc|Out|Bdv|Cdv)⊸Code
  └─╴

  Size    ← ⧻VM~Code
  Running ← <⊃Size VM~PC
  Call    ← ⍢Step Running
  WithA   ← VM~Out Call ⍜⊙(⊡₀VM~Reg)⊙◌
└─╴

# Hard-coded version of the day 17 input just for running things faster.
┌─╴Inline
  P ← (
    # A B C Out
    ⟜(◿₈⊙◌)             # bst; b = a ◿ 8
    ⊙(Xor3)             # bxl; b = b xor 3
    ⊃(∘|⋅∘|⊙◌⌊÷:⊙(ⁿ:2)) # cdv; c = a ÷ 2ⁿb
    ⊙(⊸Xor)             # bxc; b = b xor c
    ⌊÷₈                 # adv; a = a ÷ 8
    ⊙(Xor5)             # bxl; b = b xor 5
    ⊙⍜⊙⊙∘⊃(⊙⊙◌|⊂:◿₈⊙⋅∘) # out $B
  )
  Call ← ◌◌◌⍢P≠₀⊙(0 0 [])
└─╴

┌─╴Test
  Testing ← memo/∨⦷{"--test"}↘₁&args
  Gen     ← VM 0 []
  Check!  ← ⍤$"Want _, got _" ◠^0
  Want    ← ⍜⊙VM~PC⊙◌ ⊙⍜⊙VM~Out⊙◌
  # Run a test with the given start and end states. The first argument is
  # the ending PC, second the ending output array, third the ending register
  # set. Fourth is the starting register state. Fifth is the code to evaluate.
  Call ← Check!≍ ⊙Eval Want ⊙⊙(∩Gen⊙,)
└─╴

Tests! ← ⨬(||0.0 ^0)Test~Testing
Tests!(
  Test 2 [] 512_0_0 2048_0_0 0_2       # adv, A := A div const
  Test 2 [] 256_3_0 2048_3_0 0_5       # adv, A := A div B
  Test 2 [] 0_10_0 0_9_0 1_3           # bxl, B := B xor 3
  Test 2 [] 0_1_9 0_0_9 2_6            # bst, B := B mod C
  Test 200 [] 1_0_0 1_0_0 3_200        # jnz, A=1
  Test 2 [] 0_0_0 0_0_0 3_200          # jnz, A=0
  Test 2 [] 0_10_9 0_3_9 4_1234        # bxc, B := B xor C
  Test 4 5_3 0_0_333 0_0_333 [5 6 5 3] # out, C % 8; out, 3 % 8
  Test 2 [] 2048_512_0 2048_0_0 6_2    # bdv, B := A div const
  Test 2 [] 2048_256_0 2048_3_0 6_5    # bdv, B := A div B
  Test 2 [] 2048_0_512 2048_0_0 7_2    # cdv, C := A div const
  Test 2 [] 2048_3_256 2048_3_0 7_5    # cdv, C := A div B

  # Test programs.
  Test 6 [4 6 3 5 6 3 5 2 1 0] 0_0_0 729_0_0 [0 1 5 4 3 0]
  Test 6 [0 3 5 4 3 0] 0_0_0 117440_0_0 [0 3 5 4 3 0]
)

┌─╴Parse
  RC        ← ⊢-@A
  Register  ← [⊓RC⋕] °$"Register _: _"
  Registers ← ⊢↘₁⊏⍜⍉(⍏⊡0).⍉⊜Register⊸≠@\n
  Program   ← ⊜⋕⊸≠@, °$"Program: _"
  Call      ← VM 0 [] ⊓Registers Program∩°□°⊟ ⊜□ ¬⊸⦷"\n\n"
└─╴

Tests!(
  $ Register A: 123
  $ Register B: 456
  $ Register C: 789
  Test~Check!≍ 123_456_789 Parse~Registers
  Test~Check!≍ 5_4_3_2_1 Parse~Program "Program: 5,4,3,2,1"
)

PartOne ← /$"_,_" VM~Out Eval

┌─╴PartTwo
  A ← ⍜⋯♭
  Tests!(Test~Check!≍ 3442 A 2_6_5_6)

  Neighbors ← |2 (
    ⟜(⍜⊙⇌↙+₁⧻⊙⊸VM~Code)
    # => [[code...] [octets...]]
    ¤⊙(¤:)
    ≡(□₂ Eval~WithA ⊙: ⊸A⊂)⇡8
    ▽≡⌟◇(⊙□Suffix:⊙:∩°□°⊟)
  )
  
  Found ← |2 ≍⊃⋅VM~Code Eval~WithA A
  
  Call ← (
    □[]
    path◇Neighbors◇Found
    /↧≡(◇A⊣)
  )
└─╴

Tests!(
  $ Register A: 2024
  $ Register B: 0
  $ Register C: 0
  $ 
  $ Program: 0,3,5,4,3,0
  Test~Check!≍ 117440 PartTwo Parse
)

┌─╴Main
  Args   ← ▽⊸≠{"--test"} ↘₁&args
  Result ← &p $"Part _: _"
  Load   ← Parse &fras
  Parts  ← {⊃(PartOne|PartTwo)}
  Header ← &p$"# _"
  File   ← ≡Result+₁°⊏ Parts Load ⟜Header
  Call   ← ≡File Args
└─╴

Main
