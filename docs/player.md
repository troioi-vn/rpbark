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

Current design intent:

- run keeps the brisk prototype pace that existed before run mode was added
- walk is deliberately slower for more readable footwork
- movement feel is still prototype-level and expected to be tuned further

## Animation Rules

Current ground and air animations:

- `walk`
- `run`
- `run_idle`
- `jump`

Selection rules:

- if airborne, play `jump`
- if grounded and moving with run mode off, play `walk`
- if grounded and moving with run mode on, play `run`
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
