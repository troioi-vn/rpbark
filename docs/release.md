# Release Protocol

This is the basic release checklist for `R.P.Bark`.

For now, releases are manual and small. The goal is to make a known-good build, write clear notes, tag the exact commit, and upload Windows/Linux artifacts without turning the prototype into a heavy process too early.

## Naming

- Godot project version: `0.0.1`
- first test alpha tag: `v0.0.1-alpha.0`
- release title: `R.P.Bark v0.0.1-alpha.0`
- release type: GitHub pre-release

Use annotated Git tags for releases:

```bash
git tag -a v0.0.1-alpha.0 -m "R.P.Bark v0.0.1-alpha.0"
```

## 1. Prepare Before Export

Start by checking what is already changed:

```bash
git status --short
```

Review anything that will be part of the release commit. If `project.godot` changed, make sure the changes are intentional.

Run headless Godot validation:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --headless --path /home/edward/Documents/rpbark --quit
```

Open the game once and do a quick smoke test:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --path /home/edward/Documents/rpbark
```

Check the current prototype basics:

- game starts in `res://scenes/street.tscn`
- dog can walk left/right
- dog can run and stamina behaves reasonably
- dog can jump
- bark wave appears
- pause menu opens
- save/load still restores player position and stamina
- there are no obvious missing textures, script errors, or broken scene references

## 2. Bump Version

Update the project version in `project.godot` under `[application]`:

```ini
config/version="0.0.1"
```

For later releases:

- keep `config/version` as the plain project version, such as `0.0.2`
- use Git tags for pre-release labels, such as `v0.0.2-alpha.0`
- avoid tagging a build until the exported artifacts have been smoke-tested

## 3. Export Windows And Linux Builds

The local Godot export presets are currently in `export_presets.cfg`, which is ignored by Git. That means each release machine should verify the presets before exporting.

Expected local preset names:

- `Windows Desktop`
- `Linux`

Create a temporary release folder outside the repository:

```bash
mkdir -p ../../tmp/rpbark-v0.0.1-alpha.0/windows
mkdir -p ../../tmp/rpbark-v0.0.1-alpha.0/linux
```

Export release builds:

```bash
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --headless --path /home/edward/Documents/rpbark --export-release "Windows Desktop" ../../tmp/rpbark-v0.0.1-alpha.0/windows/R.P.Bark.exe
~/Desktop/Godot_v4.6.2-stable_linux.x86_64 --headless --path /home/edward/Documents/rpbark --export-release "Linux" ../../tmp/rpbark-v0.0.1-alpha.0/linux/R.P.Bark.x86_64
```

Zip the platform folders for upload:

```bash
cd ../../tmp/rpbark-v0.0.1-alpha.0
zip -r R.P.Bark-v0.0.1-alpha.0-windows.zip windows
zip -r R.P.Bark-v0.0.1-alpha.0-linux.zip linux
```

Do not commit exported builds, `.pck` files, or release zips.

## 4. Write Release Notes

Keep release notes short and player-facing.

Use this shape:

```markdown
# R.P.Bark v0.0.1-alpha.0

First test alpha for the tiny side-scrolling RPG prototype.

## Included

- dog movement: walk, run, jump
- stamina-backed running
- visual bark wave
- parallax street scene
- pause menu with simple save/load

## Known Limitations

- very small prototype map
- no real RPG progression yet
- no installer or code signing
- Windows and Linux builds only

## Test Notes

- exported from Godot 4.6.2
- smoke-tested on Linux before upload
```

Mark the GitHub release as a pre-release.

## 5. Commit, Tag, And Publish

After validation, export, and notes are ready, commit the release prep changes:

```bash
git status --short
git add project.godot docs/release.md docs/index.md
git commit -m "Prepare v0.0.1 alpha release"
```

Create the annotated tag:

```bash
git tag -a v0.0.1-alpha.0 -m "R.P.Bark v0.0.1-alpha.0"
```

Push the commit and tag:

```bash
git push origin main
git push origin v0.0.1-alpha.0
```

Create a GitHub release from tag `v0.0.1-alpha.0`, mark it as a pre-release, paste the release notes, and upload:

- `R.P.Bark-v0.0.1-alpha.0-windows.zip`
- `R.P.Bark-v0.0.1-alpha.0-linux.zip`

## 6. Post-Release Check

After publishing:

- download both uploaded artifacts from GitHub
- confirm the zips contain the expected executable and `.pck` files
- launch the Linux build locally
- if possible, test the Windows build on Windows or through a trusted tester
- add any missed steps back to this protocol while the memory is fresh

If a release needs to be corrected after publishing, prefer a new pre-release tag such as `v0.0.1-alpha.1` instead of moving an already-pushed release tag.

