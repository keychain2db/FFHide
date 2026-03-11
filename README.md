# FFHide
A simple AutoHotkey v2 script that moves a Mozilla Firefox window mostly off-screen while leaving a 1-pixel strip visible. This keeps the window technically visible to the operating system and GPU compositor so it continues rendering normally.

This technique is particularly useful for OBS Studio recording and streaming workflows, where fully minimized or hidden windows may stop rendering, freeze, or drop frames when captured.

By keeping a 1 px edge visible, the window remains part of the desktop composition pipeline, ensuring smooth GPU rendering and reliable OBS capture.

## Project Overview

When a window is minimized or completely off-screen, many applications reduce or pause rendering to save resources. For browser windows especially when capturing them in OBS Studio, this can cause:

- Frozen frames
- Stuttering capture
- Dropped frames
- WebGL / video playback pausing

This script solves the issue by:

- Moving the Firefox window almost completely outside the visible display area
- Leaving exactly 1 pixel visible
- Allowing the GPU compositor to continue rendering the window normally

As a result, OBS can capture the window smoothly, even though it is effectively hidden from the user.

## Features

- Keeps Firefox rendering while visually hidden
- Simple single-hotkey activation
- Works with AutoHotkey v2
- Lightweight and extremely fast
- Supports multi-monitor setups
- Automatically targets Mozilla Firefox

## Installation
1. Install [AutoHotkey v2](https://www.autohotkey.com/download/).
2. Download the script (`FFHide.ahk`).
3. Double-click the script to run it.

## Usage

1. Launch **Mozilla Firefox**
2. Start the AutoHotkey script
3. Focus the Firefox window
4. Press the configured **hotkey** (`Shift + Del`)

# License
This project is open-source and available under the MIT License. Feel free to modify and distribute it as needed.

# Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
