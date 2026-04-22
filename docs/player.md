# Player System

This document describes the current player implementation for `R.P.Bark`.

## Ownership

- Player scene: `res://scenes/player.tscn`
- Player logic: `res://scripts/player.gd`
- Current startup street scene that instantiates the player: `res://scenes/street.tscn`

## Responsibilities

The player currently owns:

- horizontal movement
- jump behavior
- stamina for run movement
- facing direction
- camera follow through the player scene camera
- animation switching for walk, run, run idle, and jump

The player does not currently own:

- combat
- interaction
- collectibles
- dialogue
- state machines beyond simple animation selection

## Input

- `ui_left` and `ui_right`: horizontal movement
- `ui_accept`: jump
- `Shift`: toggle run mode on or off

Run mode is a toggle, not a hold action.

## Movement

Current tuning values live in `scripts/player.gd`.

- run speed: `240.0`
- walk speed: `120.0`
- jump velocity: `-420.0`
- floor acceleration: `1400.0`
- floor deceleration: `1800.0`
- max stamina: `100.0`
- run stamina drain: `30.0` per second
- stamina recovery: `20.0` per second
- stamina recovery delay: `1.0` second
- depletion resume threshold: `25%`

Current design intent:

- run keeps the brisk prototype pace that existed before run mode was added
- walk is deliberately slower for more readable footwork
- Shift remains a run toggle, but stamina decides whether run speed is currently available
- movement feel is still prototype-level and expected to be tuned further

## Player State

`scripts/player.gd` now has the first lightweight player state value: stamina.

The state is intentionally kept inside the player script for now:

- `max_stamina` is tuning data
- `stamina` is the current runtime value
- `stamina_depletion_locked` prevents immediate run flicker after stamina reaches zero
- `stamina_changed(current, maximum)` lets UI and saving hooks observe the value without owning it

Running has two layers:

- `run_mode_enabled`: whether Shift has toggled run mode on
- `actual_run_movement`: whether this physics frame is spending stamina and using run speed

Actual run movement requires run mode, horizontal input, stamina above zero, and no depletion lockout. Standing still with run mode enabled does not spend stamina.

When stamina reaches zero, the dog automatically moves at walk speed. Stamina begins recovering after the recovery delay. If stamina was fully depleted, run speed becomes available again only after stamina has refilled to at least `25%`.

## HUD

The street scene has an always-visible stamina HUD under its `CanvasLayer`.

- HUD scene node: `CanvasLayer/StaminaHud`
- HUD script: `res://scripts/stamina_hud.gd`
- display: `Stamina` label plus a horizontal `ProgressBar`

The HUD reads the current player value on startup and then follows the player's `stamina_changed(current, maximum)` signal.

## Save / Load

The pause menu save file now stores:

- player position
- current stamina

Save path:

- `user://savegame.cfg`

On load, stamina is restored through `player.set_stamina(...)`, which clamps the loaded value between `0` and `max_stamina` and emits the update signal for the HUD. `max_stamina` is not saved yet; it remains code tuning until the project has a fuller progression/stat system.

## Animation Rules

Current ground and air animations:

- `walk`
- `run`
- `run_idle`
- `jump`

Selection rules:

- if airborne, play `jump`
- if grounded and moving without actual run movement, play `walk`
- if grounded and moving with actual run movement, play `run`
- if grounded, not moving, and run mode on, play `run_idle`
- if grounded, not moving, and run mode off, freeze the current `walk` frame instead of snapping back to frame `0`

Facing uses sprite mirroring through `AnimatedSprite2D.flip_h`.

## Art Pipeline Notes

Current player animation assets:

- `assets/player/walk_sheet.png`
- `assets/player/run_sheet.png`
- `assets/player/jump_right.png`

Sprite-sheet assumptions:

- walk sheet cells are sliced as `128x128`
- run sheet cells are sliced as `128x128`
- left movement currently uses mirroring, not separate left-facing animation sheets

Important visual rule:

- feet placement matters more than texture bounds
- if the dog looks too high or too low, adjust the sprite node position before changing gameplay collision

## Collision And Visuals

Visible art and gameplay collision are intentionally separate.

- `DogSprite` controls appearance
- `CollisionShape2D` controls gameplay collision

These should feel aligned, but they do not need to match pixel-perfectly.

## Maintenance Notes

When updating the player:

- validate the project with headless Godot after meaningful changes
- keep animation names stable unless there is a good reason to rename them
- prefer simple explicit state selection over early abstraction
- update this document when controls, animation rules, or asset assumptions change
