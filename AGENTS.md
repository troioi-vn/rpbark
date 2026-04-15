# AGENTS.md

This file gives working guidance for agents collaborating in this repository.

## Project Summary

- Engine: Godot `4.6.x`
- Project name: `R.P.Bark`
- Genre direction: pixel art side-scrolling RPG from a dog's point of view
- Current scope: a tiny 2D side-scroller prototype that serves as scaffolding for the full game
- Current entry scene: `res://scenes/world.tscn`
- Current player scene: `res://scenes/player.tscn`
- Current gameplay: move left/right, jump, parallax background, dog sprite state switching

## Repository Layout

- `project.godot`: project configuration, startup scene, display settings
- `scenes/`: `.tscn` scene files
- `scripts/`: GDScript files attached to scenes/nodes
- `assets/player/`: player PNG art and Godot import metadata
- `tmp/learning_curve.md`: compact snapshot of the human collaborator's current Godot skill level and learned concepts

Keep this structure simple. Prefer:

- scenes in `scenes/`
- behavior in `scripts/`
- imported art/audio in `assets/`

## Local Environment

Use this Godot binary on this machine:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64
```

Useful commands:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --path /home/edward/Documents/rpbark
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --headless --path /home/edward/Documents/rpbark --quit
```

When making scene or script changes, prefer validating with the headless command before finishing.

## Working Style For This Repo

- Favor small, understandable Godot scenes over clever abstraction.
- Keep reusable actor behavior in scene-specific scripts.
- Prefer composition through scenes and nodes rather than giant all-in-one scripts.
- Keep collision shapes simple even when sprite art is visually complex.
- When replacing visuals, do not tightly couple art dimensions to gameplay logic.
- Treat the current prototype as foundation code: choose names and structure that can grow into an RPG without overengineering too early.

## Scene Conventions

- Use `CharacterBody2D` for player or enemy actors that move with collision.
- Use `StaticBody2D` for terrain, platforms, and non-moving level geometry.
- Keep visible art and collision separate:
  - visuals: `Sprite2D`, `AnimatedSprite2D`, `Polygon2D`, etc.
  - gameplay collision: `CollisionShape2D`
- Use `CanvasLayer` for UI that should stay fixed on screen.
- Use `ParallaxBackground` and `ParallaxLayer` for depth layers rather than manual camera math.

## Script Conventions

- Use `_physics_process()` for movement, gravity, and collision logic.
- Read input through Godot input actions such as `ui_left`, `ui_right`, and `ui_accept` unless there is a clear reason to introduce custom actions.
- Prefer clear state selection over premature animation/state-machine complexity.
- Keep exported values and top-level constants easy to tweak during prototyping.

## Art And Asset Notes

- Transparent PNGs are a normal and preferred format for 2D character art here.
- The current player art is asymmetric left/right, so do not replace left-facing sprites by mirroring right-facing ones unless explicitly intended.
- When adding new character frames, keep feet placement and apparent ground contact consistent across images.
- If sprites look wrong in-game, first adjust sprite position/scale in the scene before changing gameplay collision.

## Editing Guidance

- Be careful editing `.tscn` files manually. Godot usually tolerates it, but small syntax mistakes can break scene loading.
- If a scene has been re-saved by Godot and gains `uid` or `unique_id` values, keep them unless there is a strong reason to remove them.
- Do not delete `.import` files casually; they are part of Godot's asset pipeline.

## Validation Expectations

Before wrapping up substantial changes:

- run the headless Godot validation command
- mention whether validation passed
- call out anything that still needs visual tuning in the editor

## Collaboration Preferences

- The human collaborator likes concise explanations plus occasional "Aha!" observations that generalize beyond the immediate task.
- English explanations can be natural and conversational; mild linguistic notes are welcome when genuinely helpful.
- Keep momentum high: prefer making a sensible improvement and explaining it, instead of stopping for minor clarifications.
- Use `tmp/learning_curve.md` as a shared memory for Godot learning progress.
- When changing project-facing docs, keep the tone aligned with an early but serious indie game scaffold rather than a throwaway demo.
- After meaningful Godot sessions, consider updating `tmp/learning_curve.md` with:
  - what was built
  - which concepts were practiced
  - what now feels comfortable
  - what remains fuzzy

## Current Gameplay References

- Main world scene: `scenes/world.tscn`
- Player logic: `scripts/player.gd`
- Procedural parallax band drawing: `scripts/parallax_band.gd`
- Player art: `assets/player/*.png`
- Learning snapshot: `tmp/learning_curve.md`

If extending the prototype, likely next steps are:

- collectibles
- NPC dialogue
- simple enemies
- camera polish
- tile-based terrain

## Documentation Expectations

- `README.md` should describe the project as `R.P.Bark`, not `hello-world`.
- Repository-facing docs should frame the current codebase as the starting scaffold for a larger dog-perspective RPG.
- If setup or run commands include an absolute local path, keep them updated when the project folder is renamed.
