# Activity 5 - Market for Lemons

For this activity, we broke up into groups of 3-6 to form different 'markets'.
Each group had one **dealer** who was dealt a random selection of cars.
Each car had both a *model* which was observable to everyone, and a *type*,
either *good* or *lemon* which was only observable to the **dealer**.

Everyone who weren't the dealer were assigned the **presenter** role. 
**Presenters** each had a budget of $£800$ to buy up to one car per round.
Their score in each round was the true value of the car they bought,
plus whatever was left over in their budget (value + (800 - price)).
The true value of a car depended on whether it was a `lemon` type,
in which case its value was 200, or a `good` type which were valued at 600.
The presenters only observed the type of car they bought 
after either all presenters had bought one car, 
or decided they would rather not buy a car (and earn 0 points that round).

## Data
[Results.csv](./Results.csv) contains the comma-separated value formatted data
from this in-class activity.
Each row in the data corresponds to one transaction of one car-buyer combo.

    * `group` gives the number associated with each group or table of players
    * `round` gives the round of the game in which the transaction occurred
    * `model` is the name of the car model
        + different models had different probabilities of being lemons
            - `Golf` models were 100% lemons
            - `Fiesta` models were 50% lemons
            - `Nova` models were 20% lemons
    * `price` is the price (in pounds) agreed upon by the dealer and presenter
    * `cartype` is either 'lemon' or 'good' based on the true value of the car
    * `resale_price` is the buyer's score for that round (value + 800 - price)
    * `dealer_profit` is the dealer's score or that round in pounds
        + It is the total of (value - price) for all cars sold in that round 
