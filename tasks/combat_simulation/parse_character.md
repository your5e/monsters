@after parse_monster.md

Parse the Markdown description of a character to build a Character() class.

- [ ] extract key details from the markdown
        - name
        - AC
        - HP (use average, store both average and roll)
        - initiative bonus
        - ability scores
        - ability check modifiers
        - saving throw modifiers
- [ ] extract named attack actions
        - ignore multiattack and AOE for now, just melee/ranged/forced saving throws
- [ ] add `get_tactic()` which returns the method to call for action and bonus action
        - at this point, the only choice is to take the `attack()` action
