# Pause Menu

This document describes the current Esc menu for `R.P.Bark`.

## Ownership

- Menu scene nodes: `res://scenes/street.tscn`
- Menu logic: `res://scripts/pause_menu.gd`
- Current save path: `user://savegame.cfg`

## Responsibilities

The pause menu currently owns:

- opening and closing from `Esc`
- fading the game slightly under a screen-fixed overlay
- pausing gameplay while the menu is open
- saving the player's current position
- loading the player's saved position
- continuing play
- quitting the game

It does not yet own:

- multiple save slots
- save file versioning
- scene transitions
- loading on startup
- inventory, quest, or dialogue state

## Menu Behavior

Current options:

- `Save`
- `Load`
- `Continue`
- `Quit`

`Save` is focused by default each time the menu opens.

The menu runs while the rest of the scene tree is paused. This is done by setting the pause menu to always process, then using `get_tree().paused = true` when the menu opens.

## Save And Load

The current save file is intentionally tiny.

Saved values:

- `player/position_x`
- `player/position_y`

Loading restores the player's `global_position`, clears `velocity`, and closes the menu. Clearing velocity matters because saved position is durable game state, while movement velocity is transient runtime state.

If there is no save file yet, `Load` keeps the menu open and shows a short status message.

## Maintenance Notes

When extending saving:

- keep the first version readable and explicit
- add new save keys only when real gameplay state exists
- consider save versioning before changing the meaning of existing keys
- reset transient state after loading if it should not survive across saves
- update this document when save data or menu options change
