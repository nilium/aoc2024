#!/usr/bin/env uiua

┌─╴Parse
  Level  ← ⋕
  Report ← □⊜Level≠" ".
  # Parse each line of input as a report containing a row of numbers.
  Call ← ⊜Report ≠@\n.
└─╴

┌─╴PartOne
  # Test if an array is sequential (either rising or descending).
  Sequential ← ↥⊃(≍⍏|≍⍖)⟜(⇡⧻)
  # Test if each two rows of an array are in the range [1,3].
  InRange ← /××⊃(≥1|≤3) ≡(⌵-°⊟) ◫ 2

  # Test if a report array is safe.
  Safe ← ×⊃Sequential InRange

  # Return the number of reports deemed safe by part one rules.
  Call ← /+≡(Safe °□)

└─╴

┌─╴PartTwo
  VariedSafe ← (
    °⊏             # Get the indices of the input array.
    ⊙¤             # Fix the input array.
    ≡(⍜↻(↘1)       # Remove the index being tested.
      PartOne~Safe # Re-check under part one rules.
    )
    /↥ # If at least one case was valid, the report is valid.
  )

  Safe ← (
    PartOne~Safe .
    ⨬(VariedSafe # If not safe under part one rules, try removing an index.
    | 1◌         # Otherwise proceed without further checks.
    )
  )

  # Return the number of reports deemed safe by part two rules.
  Call ← /+≡(Safe °□)
└─╴

PrintResult ← &p $"_: _" °⊟

↘1&args
≡(Parse &fras
  # Compute results.
  [⊃({"Part One" PartOne}
    | {"Part Two" PartTwo}
    )]
  # Print results.
  ≡PrintResult
)
