# Godot Learning Curve

This is a compact, updateable snapshot of current Godot understanding.

## Current Level

Early intermediate with real hands-on practice in a small but meaningful 2D prototype.

Comfort level:

- can open and run a Godot project
- can understand the high-level structure of a small Godot game
- can follow and discuss simple GDScript gameplay code
- can make scene, art-placement, and camera changes with confidence
- can rename and reorganize project-facing structure without losing the thread of the project
- can use docs and commit history to recover architectural intent

## Concepts Already Learned

- Godot project structure:
  - `project.godot`
  - `scenes/`
  - `scripts/`
  - `assets/`
- Scene and node model
- Scene as reusable building block
- Main scene / startup scene
- `Node2D` as a generic 2D container
- `CharacterBody2D` for controllable actors
- `StaticBody2D` for terrain/platforms
- `CollisionShape2D` for gameplay collision
- Separation of visuals and collision
- `CanvasLayer` for screen-fixed UI
- `Camera2D` following the player
- camera limits and their relation to viewport size
- `ParallaxBackground` and `ParallaxLayer`
- horizontal parallax versus vertical anchoring
- Procedural drawing with `_draw()`
- Transparent PNG workflow for 2D sprites
- `AnimatedSprite2D` and state-based sprite switching
- startup scene changes and project-level scene ownership
- documentation as part of keeping a prototype coherent

## GDScript / Code Ideas Already Seen

- constants for movement tuning
- `_ready()`
- `_physics_process(delta)`
- gravity application
- input via `Input.get_axis()`
- jump input via `Input.is_action_just_pressed()`
- `velocity`
- `move_and_slide()`
- checking `is_on_floor()`
- simple state selection: idle / run / jump
- facing direction tracking
- reading project settings from code
- toggling behavior with `_unhandled_input(event)`
- opening and closing a pause menu from keyboard input
- using `get_tree().paused` with an always-processing UI node
- saving minimal game state with `ConfigFile` and `user://`
- loading minimal game state back from `ConfigFile`
- freezing animation state intentionally instead of defaulting to frame zero
- declaring and emitting a simple signal for player state changes
- using a `ProgressBar` as a screen-fixed HUD meter
- separating run intent from actual stamina-backed run movement
- dynamically instancing a short-lived visual effect scene from player input
- using a `CanvasItem` shader to make a 2D screen-space distortion ring
- keeping visual feedback separate from future gameplay collision/detection

## Practical Things Already Done

- built a small side-scroller prototype
- added player movement left/right
- added jumping
- added parallax background
- replaced placeholder player shape with dog sprite art
- used separate left/right/jump/run art
- refactored player facing to use one animation direction plus sprite mirroring
- changed idle behavior to freeze the last ground locomotion frame
- added a toggleable run mode with separate walk/run sprite sheets
- renamed the first environment from a generic `world` scene to a specific `street` scene
- reorganized environment art into clearer folders such as `assets/street/clouds`, `assets/street/houses`, and `assets/street/trees`
- added a proper project docs area with focused system pages
- learned to inspect recent commits to reconstruct what changed and why
- adjusted a parallax scene so visual layers, ground length, and camera limits end together
- aligned sprite bottoms to a shared street baseline instead of eyeballing each asset independently
- fixed a mismatch between collision geometry and visible ground polygons
- added an Esc pause menu with Save, Continue, and Quit options
- added a first tiny real save file containing the player's position
- added a Load option that restores the saved player position
- added a simple `I` key inventory overlay with starter items
- added stamina-backed run movement with drain, delayed recovery, and a depletion lockout
- added a fixed HUD stamina bar driven by the player's `stamina_changed` signal
- expanded the save file from position-only to position plus stamina
- added a visual-only bark action on `B` that spawns a fast expanding warped-space ring
- learned that `Camera2D` limits are screen-edge limits, not player-position limits
- learned that street-facing parallax layers often want depth on `x` but stability on `y`
- learned that collidable level geometry should stay out of `ParallaxLayer`, even when the matching art looks like background scenery
- learned that named input actions can express gameplay intent better than checking a raw key everywhere
- learned that a spawned effect can live in world space independently from the actor that created it
- learned that screen-reading shaders can create distortion without changing the underlying world nodes
- validated the project with local Godot executable
- learned the basic idea of desktop export

## Tools / Editor Ideas Touched

- Godot editor
- scene files (`.tscn`)
- script files (`.gd`)
- imported PNG assets
- sprite-sheet workflow with `SpriteFrames` and frame slicing
- toggled player state with keyboard input events
- built a small `Control` menu inside a `CanvasLayer`
- bound a `ProgressBar` to player state with a signal
- project docs in `docs/`
- `git log` / commit history as a learning and orientation tool
- export dialog
- headless project validation

## Current Mental Model

Current understanding is strongest in these ideas:

Godot is a tree of nodes assembled into scenes, where scripts add behavior to specific nodes.

Movement is not "magic"; we update `velocity`, apply gravity/input, and let Godot resolve collision.

Visuals, collision, camera, and UI are separate layers of responsibility.

Folder names and scene names work best when they describe gameplay meaning, not just generic container words like `world`.

Parallax layer width is about surviving camera travel, while ground and camera limits define the real playable extent.

Godot editor work and repo maintenance are not separate worlds; renaming scenes, updating docs, and keeping project structure honest are part of game development too.

If the player can stand on it, the node should usually live in world space rather than in a parallax layer.

## Things That Now Feel Comfortable

- reading and editing small `.tscn` scene files carefully
- tracing ownership between `project.godot`, scenes, scripts, and assets
- adjusting player movement and animation behavior with guidance
- reasoning about parallax layers, camera limits, and gameplay extents together
- distinguishing decorative scene depth from real gameplay geometry
- organizing assets into meaningfully named folders
- updating lightweight docs when systems change
- building small screen-fixed UI with `Control` nodes
- binding a `ProgressBar` to player state through a signal
- adding a named input action in `project.godot`
- reusing the `CanvasLayer` overlay pattern for another menu
- reading a small effect scene/script/shader as one reusable gameplay-feedback unit

## Things Not Yet Learned Deeply

- custom input map setup
- tilemaps / tilesets
- animation player vs animated sprite vs sprite-sheet import workflow at a broader level
- enemies and combat
- collectibles and scoring
- dialogue systems
- sound and music
- UI systems with `Control`
- broader save/load design for many values and versioned save data
- instancing many gameplay objects dynamically
- finite state machines
- physics layers and masks
- exporting to multiple platforms in practice

## Good Next Steps

- add a collectible coin
- add a simple NPC with one dialogue line
- add an enemy that moves back and forth
- learn signals through pickup detection
- create a small tile-based level
- add sound effects for jump / pickup
- practice one editor-driven task and one code-driven task in the same session to strengthen the scene/script mental bridge

## Collaboration Notes For Future Sessions

- prefers concise explanations over long theory
- benefits from practical examples tied to the current project
- already understands programming concepts, so Godot ideas can be explained using engineering language
- now benefits from tying new Godot concepts to concrete repo changes and commit history
- good moment to introduce one new Godot concept at a time, but with slightly more autonomy than at the start

## Update Rule

After meaningful sessions, update:

- what was built
- which Godot concepts were used
- what now feels comfortable
- what is still fuzzy
