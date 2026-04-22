# Street Scene

This document describes the current environment scene for `R.P.Bark`.

## Ownership

- Main environment scene: `res://scenes/street.tscn`
- Player scene instanced into it: `res://scenes/player.tscn`
- Procedural far band script: `res://scripts/parallax_band.gd`

## Purpose

`street.tscn` is the current playable scaffold for the project.

It is responsible for:

- presenting the dog-perspective city street
- instancing the player into the world
- defining the walkable ground
- providing layered depth through parallax
- holding lightweight prototype UI such as the control hint label and pause menu

It is not yet responsible for:

- NPCs
- enemies
- collectibles
- dialogue triggers
- level transitions
- interaction zones

## Scene Structure

Current high-level structure:

- `Street` as the root `Node2D`
- `ParallaxBackground` for scenic layers
- `Ground` as the main `StaticBody2D` floor
- optional `Platform` for prototype collision experiments
- `Player` as an instanced scene
- `CanvasLayer` for screen-fixed UI

This keeps scenery, collision, actor logic, and UI clearly separated.

## Parallax Layout

The scene currently uses three parallax depth bands:

- `FarLayer`: distant sky decoration and the procedural far band
- `MidLayer`: house facades, walls, and some middle-distance trees
- `NearLayer`: large foreground trees

Current motion intent:

- horizontal parallax is used for depth
- vertical parallax is intentionally disabled by using `motion_scale.y = 1`

That second rule matters. The street-facing houses and trees should stay visually grounded against the non-parallax floor during gameplay. Allowing vertical drift looked acceptable in the editor but created a visible gap in motion.

Another important rule:

- only decorative visuals should live under `ParallaxLayer`

Collidable gameplay surfaces should not be placed inside parallax layers. If the player must stand on it, collide with it, or use it as real level geometry, keep that node in normal world space.

## Ground And Camera Rules

The ground is the gameplay truth for scene length.

- `Ground/CollisionShape2D` defines the real walkable extent
- `Ground/Soil` and `Ground/Top` should always match that extent visually
- `Player/Camera2D.limit_right` must be sized from the gameplay extent, not only from the art width

Practical rule:

- parallax art width answers: "how much camera travel can this layer survive?"
- ground width answers: "how far can the player actually go?"

When the two disagree, gameplay should usually win and the art should be extended or retuned.

## Visual Alignment Rules

The current street uses a shared visual baseline.

- bottoms of houses and street trees are aligned against the same street line
- collision and visible soil should not diverge
- if something looks too high or too low, fix node position first before changing gameplay collision

This is especially important with mixed pixel-art assets from different sources or scales.

## Art Notes

Current street art is organized as:

- `assets/street/clouds/`
- `assets/street/houses/`
- `assets/street/trees/`

Keep that split. It makes it easier to reason about reuse and future replacement.

When adding more street pieces:

- preserve the feet-to-ground or base-to-ground relationship
- prefer adding new sprites over stretching collision to hide visual gaps
- keep decorative foreground elements from blocking too much of the player silhouette

Current exception for gameplay honesty:

- `WallSegment03` and `WallSegment04` now live under root-level `StreetProps` instead of `MidLayer`

They visually belong to the street composition, but they also act as real platform tops. Keeping them in world space prevents collision from drifting away from the visible wall tops during camera movement.

## Maintenance Notes

When editing the street scene:

- validate with headless Godot after meaningful changes
- treat `.tscn` edits carefully because small syntax mistakes can break scene loading
- keep scene names descriptive and gameplay-oriented
- if a visual element needs collision, consider splitting it into:
  - a world-space gameplay surface
  - an optional parallax-only decorative companion
- update this document when scene responsibilities or layout rules change

## Likely Next Extensions

- collectible pickups placed along the street
- one NPC with a simple dialogue trigger
- simple enemy patrol on the ground plane
- camera polish near scene edges
- tile-based replacement for parts of the current hand-placed ground
