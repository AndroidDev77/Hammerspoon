
# Three-Finger Swipe Gesture Script for Hammerspoon

## Overview
This script enables gesture-based volume control on macOS using **Hammerspoon**. By swiping up or down with three fingers on your trackpad, you can increase or decrease the system volume.

### Features:
- **Three-Finger Swipe Gesture Detection**: Adjusts the volume based on trackpad swipes.
- **Smooth Integration**: Uses macOS's native media keys (`Volume Up` and `Volume Down`).
- **Customizable Thresholds**: Modify swipe sensitivity and debounce timing as needed.

---

## Installation
1. **Prerequisites**:
   - macOS
   - [Hammerspoon](https://www.hammerspoon.org/) installed and configured.

2. **Setup**:
   - Clone this repository:
     ```bash
     git clone [your-repo-url]
     ```
   - Copy the script to your Hammerspoon configuration directory:
     ```bash
     cp three_finger_swipe.lua ~/.hammerspoon/init.lua
     ```

3. **Reload Hammerspoon**:
   - Open the Hammerspoon Console with `Cmd + Alt + C`.
   - Type `:reload()` and press Enter.

4. **Start Using**:
   - Swipe up with three fingers to increase the volume.
   - Swipe down with three fingers to decrease the volume.

---

## Configuration
You can customize the script by editing the following variables:

- **`deltaThreshold`**: Minimum swipe distance to trigger a volume change.
  ```lua
  local deltaThreshold = 0.5
  ```
- **`debounceTime`**: Time (in seconds) between consecutive volume changes.
  ```lua
  local debounceTime = 0.1
  ```

---

## License
```
Copyright (c) 2024 [Your Name]. All rights reserved.

This software is the intellectual property of [Your Name] and is provided
solely for personal use. Any redistribution, modification, or commercial use
of this software is strictly prohibited without prior written consent from
[Your Name].

For inquiries or licensing requests, please contact [your email or website].
```

---

## Author
- **Name**: [Your Name]
- **Contact**: [Your Email or Website]
