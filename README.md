# R.P.Bark

R.P.Bark is a pixel art side-scrolling RPG prototype from a dog's point of view, built in Godot 4.6.

Right now this repository is the game's scaffold: a small playable foundation with movement, stamina-backed running, jumping, parallax background layers, dog sprite state switching, and a tiny pause/save/load menu. The goal is to keep that base simple, readable, and easy to extend into a real RPG.

## Current State

- engine: Godot `4.6.x`
- main scene: `res://scenes/street.tscn`
- player scene: `res://scenes/player.tscn`
- current gameplay: walk, stamina-backed run, jump, collide with terrain, view parallax scenery, save/load player position and stamina from the Esc menu

## Run Locally

Use the local Godot binary noted in `AGENTS.md`:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --path /home/edward/Documents/rpbark
```

Headless validation:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --headless --path /home/edward/Documents/rpbark --quit
```

## Repository Layout

- `project.godot`: Godot project configuration
- `scenes/`: game scenes
- `scripts/`: GDScript behavior
- `assets/`: art and imported asset metadata
- `tmp/learning_curve.md`: shared notes about current Godot learning progress

## Near-Term Direction

- grow the prototype into an RPG-friendly foundation
- add collectibles, NPC dialogue, and simple enemies
- improve camera feel and level structure
- move toward tile-based terrain and richer world interactions

## Development Notes

- keep scenes small and understandable
- prefer composition over giant scripts
- separate visuals from gameplay collision
- validate substantial scene or script changes with headless Godot before wrapping up
