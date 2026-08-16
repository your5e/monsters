@after parse_monster.md parse_character.md

Simulate a single combat bout. The function will take groups of combatants. Those in
the same group are considered allied and will not attack their allies.

1. Roll for initiative.
2. Start the next round.
3. In initiative order, each combatant chooses their tactics then carries them out.

Combat continues until only one group remains standing.

- [ ] implement simulate_combat([(), ()...]) using the methods on each combatant
        - get_tactic returns an action and bonus action to use
        - use the action and bonus action
        - returns a tuple of groups that mirror the arguments, with their
          current HP
- [ ] also return a log of every action and result which can be used to produce a
      report of the combat
