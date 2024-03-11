# Activity 3: Pirate Treasure

Credit to Dr. Tom Crawford of [TomRocksMaths.com](https://tomrocksmaths.com/).
Original post at: https://tomrocksmaths.com/2022/02/10/pirate-game-theory-puzzle/

## Puzzle 

Five pirates of different heights have a treasure of 100 gold coins, 
which they plan to share amongst themselves. 
They decide to split the coins using the following scheme:

The tallest pirate proposes how to share the coins, 
and ALL pirates (including the tallest) vote for or against it.

If 50% or more of the pirates vote for it, then the coins will be shared that way. 
Otherwise, the pirate proposing the scheme is thrown overboard,
and the process is repeated with the pirates that remain.

Since pirates are generally known to be bloodthirsty, 
if a pirate will get the same number of coins if voting for or against a proposal,
they will choose to vote against so that the proposer is thrown overboard.

## Data

For our in-class activity, the class broke up into groups of 4 to 5 people.
Each group decided on who would propose first, second, third, ..., last.

    * `Round 1 Proposal:` is the distribution proposed by the first pirate 
      for each person at their table to recieve out of the 100 total coins
    * `Round 1 Vote:` is the vote by each pirate for that proposed distribution
        * either `yes` or `no`

If the Round 1 Proposal was rejected by more than 50% of pirates,
then the game continued until either one pirate's proposal was voted for 
by at least a 50% majority, or until there was only one pirate left.

    * `Final Payouts` records the payouts after the last round of play
