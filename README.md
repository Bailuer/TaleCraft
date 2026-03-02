# TaleCraft

> An interactive reading and experience app for **inclusivity**, **wellbeing**, and **youth mental health** (work in progress).

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue.svg)](https://developer.apple.com/ios/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

---

## About

TaleCraft combines storytelling, sound, and accessibility into a safe, explorable space for young users. The app is designed to use Apple’s **Liquid Glass** design language and frameworks such as Core ML and Swift Charts. The current repo holds an **early prototype**: draw on screen in AR and your strokes become 3D objects in the real world.

---

## Vision

| | |
|---|---|
| **Theme** | Inclusivity, positivity, youth mental health |
| **Format** | Interactive reading + soundscape — scroll, choose branches, adjust emotion/volume to shape the story and environment |

**Planned technical highlights**

- **Liquid Glass** — translucency, reflection, flowing backgrounds  
- **Core ML / Create ML** — breathing rhythm, emotion detection, sound/music emotion classification  
- **Swift Charts** — rhythm lines, waveforms, energy curves  
- **SoundAnalysis** — audio rhythm and emotion intensity  
- **SwiftUI animations** (PhaseAnimator / KeyframeAnimator) — breathing halos, sound-wave effects  
- **Core Haptics** — tactile feedback for breathing/rhythm  
- **SwiftData** — preferences, logs, reading achievements  
- **TipKit** — onboarding and hints  
- **AVSpeechSynthesizer** — voice narration  
- **Accessibility** — VoiceOver, Dynamic Type, high-contrast  

**Planned interactions**: scene-linked scrolling, tap-to-trigger sound/haptics, choose-your-path reading, emotion/volume sliders, achievement cards, voice narration, full accessibility.

---

## Current implementation (incomplete)

The repo contains an **AR + drawing prototype** to validate the “draw → 3D” interaction. It does **not** yet include the full story, Liquid Glass UI, Core ML, or Swift Charts.

### Implemented

- **RealityKit + ARKit** — horizontal plane detection, AR scene, Coaching Overlay  
- **PencilKit** — transparent canvas over AR; finger and Apple Pencil  
- **Draw → 3D** — stroke is raycast onto a detected plane; a 3D cube (with drop animation) is spawned and the canvas clears for a “draw it, it becomes 3D” effect  
- **SwiftUI + AppState** — shared state (`ARView`) across SwiftUI, PencilKit, RealityKit  
- **Basic UI** — status message, clear canvas / clear 3D button  

### Tech stack (current)

| Layer   | Frameworks |
|--------|------------|
| UI     | SwiftUI    |
| AR/3D  | RealityKit, ARKit |
| Drawing| PencilKit  |
| Project| Swift Package (Swift 6, iOS 16+) |

### Not yet implemented

Liquid Glass UI, Core ML / SoundAnalysis, Swift Charts, SwiftData, story content, branch narrative, soundscapes, emotion sliders, achievements, TipKit, voice narration, full accessibility.

---

## Getting started

### Requirements

- **Xcode** 16+ or **Swift Playgrounds** (iOS)
- **Device**: iPhone or iPad (camera + AR required; simulator not supported)
- **iOS** 16.0+

### Run the app

1. Clone the repo and open the project:
   ```bash
   git clone https://github.com/YOUR_USERNAME/TaleCraft.git
   cd TaleCraft
   ```
2. Open `Talecraft.swiftpm` in Xcode or Swift Playgrounds.
3. Select your device and run. Allow **Camera**, **Motion**, and (if prompted) **Microphone** when asked.

### Project structure

```
TaleCraft/
├── README.md
├── LICENSE
├── .gitignore
└── Talecraft.swiftpm/
    ├── Package.swift      # SPM manifest
    ├── Info.plist         # Permissions (camera, motion, mic)
    ├── TaleCraftApp.swift # App entry
    └── ContentView.swift  # AR + PencilKit UI and logic
```

---

## Project info

| | |
|---|---|
| **Bundle ID** | `com.bailueryu.Talecraft` |
| **Platform**  | iOS 16.0+, iPhone & iPad |
| **Category** | Education |
| **Status**   | Work in progress; current state is an AR + PencilKit prototype. |

---

## License

This project is licensed under the **GNU General Public License v3.0** — see [LICENSE](LICENSE) for details.

---

*TaleCraft — Stories and sound for an inclusive, uplifting experience.*
