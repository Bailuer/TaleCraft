# TaleCraft

> An interactive reading and experience app for **inclusivity**, **wellbeing**, and **youth mental health** — Swift Student Challenge entry (work in progress).

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue.svg)](https://developer.apple.com/ios/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## About

TaleCraft combines storytelling, sound, and accessibility into a safe, explorable space for young users. The app is designed to use Apple’s **Liquid Glass** design language and **1–2 challenging frameworks** (e.g. Core ML, Swift Charts) as required by the Swift Student Challenge. The current repo holds an **early prototype**: draw on screen in AR and your strokes become 3D objects in the real world.

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

**Planned interactions** (inspired by winning SSC apps): scene-linked scrolling, tap-to-trigger sound/haptics, choose-your-path reading, emotion/volume sliders, achievement cards, voice narration, full accessibility.

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

## Swift Student Challenge (SSC) essay tips

1. **Why this app** — Link your interests (story, sound, mental health, inclusivity) to the goal: a safe, explorable space that uses story and sound to reduce anxiety and support expression.
2. **Development process** — Idea → tech choices (Liquid Glass, Core ML, Swift Charts) → AR + drawing prototype → planned story, soundscapes, persistence.
3. **Challenges** — e.g. sharing `ARView` and raycasting across SwiftUI, PencilKit, and RealityKit; or prioritizing a working prototype vs. full story + theme under time limits.
4. **Inclusivity** — Describe planned VoiceOver, Dynamic Type, high-contrast, narration, and emotion/volume controls.

---

## Project info

| | |
|---|---|
| **Bundle ID** | `com.bailueryu.Talecraft` |
| **Platform**  | iOS 16.0+, iPhone & iPad |
| **Category** | Education |
| **Status**   | Swift Student Challenge entry — incomplete; current state is an AR + PencilKit prototype. |

---

## License

This project is licensed under the **MIT License** — see [LICENSE](LICENSE) for details.

---

*TaleCraft — Stories and sound for an inclusive, uplifting experience.*
