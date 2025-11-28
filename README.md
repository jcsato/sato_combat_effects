# Sato's Combat Effects

A mod for the game Battle Brothers ([Steam](https://store.steampowered.com/app/365360/Battle_Brothers/), [GOG](https://www.gog.com/game/battle_brothers), [Developer Site](http://battlebrothersgame.com/buy-battle-brothers/)).

## Table of contents

-   [Features](#features)
-   [Requirements](#requirements)
-   [Installation](#installation)
-   [Uninstallation](#uninstallation)
-   [Compatibility](#compatibility)
-   [Building](#building)

## Features

Adds a number of new effects to the game that rebalance certain specific skills. These were originally a part of my [balance mod](https://github.com/jcsato/sato_balance_mod) - I've moved them to their own standalone mod as they take broader swings than that mod, which is mostly number adjustments that are more felt than seen.

If either this mod or the balance mod appeal to you, you might also want to check out my [enemy rebalance mod](https://github.com/jcsato/sato_enemy_balance_mod).

**Exertion:**
- Characters now recover a minimum of 10 Fatigue at the start of the turn, down from 15.
- Characters ending their turn with less than 10 available Fatigue now receive a stack of the 'Exertion' effect, which reduces Fatigue recovery per turn by 1 for each stack.
- Exertion can stack up to 5 times.
- 1 stack of Exertion is removed at the end of the turn for every 10 available Fatigue.
- The 'Recover' skill removes all accumulated exertion.

**Bandages:**
- The 'Bandage Ally' skill can now be used regardless of whether the user or target is engaged in melee.
- Both the user and the target of the 'Bandage Ally' skill receive a stack of the 'Vulnerable' effect, which reduces Melee and Ranged Defense by 4 per stack and lasts 1 turn. If a character uses the skill on themself, they receive 2 stacks for -8 defense total.

**Shield Breaking:**
- Breaking a character's shield now inflicts the 'Off Balance' effect, which lasts for 1 turn, reduces AP by 2, and prevents the character from benefitting from Double Grip.

**Flowing Strikes:**
- The 'Duelist' perk now grants the 'Flowing Strikes' effect on melee attacks, which refunds 2 Fatigue per stack when making a melee attack and is removed at the end of the turn, on movement, or when the character uses a non-melee attack skill.

**Tryout:**
- Trying a character out now grants a mood boost and the 'Tried out' effect, which grants +10% XP gain for 2 days after hire.

## Requirements

1) [Modding Script Hooks](https://www.nexusmods.com/battlebrothers/mods/42) (v20 or later)

## Installation

1) Download the mod from the [releases page](https://github.com/jcsato/sato_combat_effects/releases/latest)
2) Without extracting, put the `sato_combat_effects_*.zip` file in your game's data directory
    1) For Steam installations, this is typically: `C:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data`
    2) For GOG installations, this is typically: `C:\Program Files (x86)\GOG Galaxy\Games\Battle Brothers\data`

## Uninstallation

1) Remove the relevant `sato_combat_effects_*.zip` file from your game's data directory

## Compatibility

This _should_ be fully save game compatible, i.e. you can make a save with it active and remove it without corrupting that save. If you've tried out characters, you might need them to despawn from town rosters or lose the 'Tried out' effect first before removing.

This should be fairly compatible with other mods, except where obvious (e.g. mods that change the same thing).

### Building

To build, run the appropriate `build.bat` script. This will automatically compile and zip up the mod and put it in the `dist/` directory, as well as print out compile errors if there are any. The zip behavior requires Powershell / .NET to work - no reason you couldn't sub in 7-zip or another compression utility if you know how, though.

Note that the build script references the modkit directory, so you'll need to edit it to point to that before you can use it. In general, the modkit doesn't play super nicely with spaces in path names, and I'm anything but a batch expert - if you run into issues, try to run things from a directory that doesn't include spaces in its path.

After building, you can easily install the mod with the appropriate `install.bat` script. This will take any existing versions of the mod already in your data directory, append a timestamp to the filename, and move them to an `old_versions/` directory in the mod folder; then it will take the built `.zip` in `dist/` and move it to the data directory.

Note that the install script references your data directory, so you'll need to edit it to point to that before you can use it.
