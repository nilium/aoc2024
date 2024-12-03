#!/usr/bin/env uiua

┌─╴PartOne
  Parse ← (
    # Grab every match for mul(X,Y) there is. NOTE: there are no negative numbers in the input that
    # I got.
    regex $ mul\((\d+),(\d+)\)
    ≡(⋕↘1) # For each match, drop the matched text and parse the two numbers.
  )

  Call ← (
    Parse
    /+≡/× # Multiply each X,Y pair and sum the products.
  )
└─╴

┌─╴PartTwo
  Parse ← (
    # I hate reaching for a regex, but this is probably a good use of one.
    ⬚"" regex $ mul\((\d+),(\d+)\)|(do(?:n't)?)\(\)
    ≡(↘1
      # Try to parse the match as the X,Y pair of numbers, otherwise keep only the tail do/don't
      # match.
      ⍣(□⋕↙2) (°¤↘2)
    )
    # Stick an implicit "do" on the front of the parsed set that a) won't affect the sum and b)
    # ensures we always start with a do, even though input appears to never start with a don't.
    ⊂{"do"}
    # Group runs of numbers following their leading do/don't. This is why we want to ensure there's
    # a leading "do" in every case. Yields an array of {{} {"do" …} {"don't" …} …}. Because
    # it always leads with an empty array, chop the leading empty array off. See the scan docs for
    # another example of this.
    ↘1⊕□\+(+≡(/×)⊃(={"do"}|={"don't"}).)
  )

  Call ← (
    Parse
    # Sum all cases together, multiplying each sum by 1 only if its first element is "do".
    ≡(°□
      ⊃(={"do"} ↙1   # Get the multiplier for the sum (1 = do, 0 = anything else).
      | /+≡(/×°□) ↘1 # Sum the product of each pair of numbers.
      )
      ×  # Multiply the sum and multiplier.
      °¤ # FIXME: Un-fix the result because somewhere along the way it got wrapped.
    )
    /+ # Sum the sums of all do/don't mul() groups.
  )
└─╴

↘1 &args
≡(&fras
  [⊃({"Part One" PartOne}
    | {"Part Two" PartTwo})]
  ≡(&p $"_: _" °⊟)
)
