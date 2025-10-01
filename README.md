# AGI.edu – Adaptive Storybook-Like Learning App for Pre‑K

AGI.edu is an iOS educational app for children aged 3–5 that blends the adaptive practice engine of platforms like IXL with the look and feel of a soft, nature‑themed storybook.  The home screen invites children to choose a **career path**—doctor, veterinarian, potions master, or astronaut—represented by gentle watercolor icons.  Based on the chosen path and the child’s progress, the app adjusts the difficulty of games in real time.  This repository contains a prototype SwiftUI implementation illustrating the core architecture and a few sample games.

## Why another learning app?

Researchers have shown that high‑quality educational apps for preschoolers are scarce.  Many “educational” titles lack clear learning outcomes and are cluttered with advertising【836522931887883†L312-L318】.  Effective apps for young children should:

- Be **developmentally appropriate** and child‑driven, using open‑ended activities to engage young learners【836522931887883†L304-L309】.
- Provide a **highly visual interface** with minimal text to reduce cognitive load【836522931887883†L312-L317】.
- Include **prosocial, non‑violent content**, celebrate diversity, and avoid manipulative monetization【836522931887883†L314-L317】.
- Scaffold learning with clear feedback and adjust difficulty to meet each child at their level【412536993636793†L120-L129】.
- Offer responsive controls and easy ways to exit activities so that children feel in control【928426571583315†L284-L288】.

AGI.edu was designed with these principles in mind.  It avoids ads and in‑app purchases, uses simple tap interactions instead of text entry, and includes an adaptive engine that raises or lowers the difficulty depending on how the child is doing.

## Overview of the prototype

The current prototype demonstrates the overall structure of the app.  It uses **SwiftUI** for declarative UI and an **`AdaptiveEngine`** class to track correct and incorrect answers and adjust the difficulty.  The home screen presents four watercolor icons.  Tapping an icon navigates to a themed path containing a sequence of games.  Each path includes two sample games, with room to add many more.
### Career paths

| Icon | Path | Sample learning games |
|-----|------|-----------------------|
| Doctor (red cross) | **Doctor Path** | *Band‑Aid Prepositions* – a child sees a cabinet with band‑aids either above or below and must select the correct preposition.  \\  *Number Check‑Up* – count cartoon germs on a bandage and select the correct numeral. |
| Veterinarian (paw print) | **Vet Path** | *Match the Animals* – drag animal icons to their matching habitats, reinforcing classification and memory.  \\  *Pet Weigh‑In* – compare the sizes of cartoon animals (large vs. small) and pick the heaviest pet. |
| Potions Master (purple potion) | **Potions Path** | *Color Mixing* – tap colored vials to mix primary colors and create secondary colors (e.g., red + blue = purple).  \\  *Shape Sorting* – drop ingredient shapes (circle, triangle, square) into the correctly shaped bottle opening. |
| Astronaut (rocket) | **Astronaut Path** | *Rocket Fuel Count* – count stars or planets and choose the correct number to fuel the rocket.  \\  *Space Patterns* – arrange planets in simple repeating patterns (e.g., red – blue – red – ?), encouraging early algebraic thinking. |

These games are intentionally simple and brief (a minute or less) to align with research showing that **short, daily practice with positive language helps children build perseverance and a growth mindset**【412536993636793†L140-L143】.

### Adaptive engine

The `AdaptiveEngine` class tracks the number of correct and incorrect responses.  When the child answers correctly more than 80 % of the time on five consecutive questions, the level is increased; if accuracy drops below 50 % the level is decreased.  Each game queries the engine to determine which variation to present—for example, counting fewer objects at lower levels and more objects at higher levels.  This simple mechanism demonstrates how you could implement the adaptive practice found in tools like IXL, where students are continually challenged at the right difficulty【412536993636793†L120-L129】.  More sophisticated algorithms, such as Bayesian knowledge tracing, can be integrated later.


### Files and directories

```
AGI.edu/
├── README.md               – this file
├── App/
│   ├── AGIEduApp.swift      – `@main` entry point for the SwiftUI app
│   ├── ContentView.swift    – root view that routes to the home screen
│   ├── HomeView.swift       – displays watercolor icons and navigation
│   ├── AdaptiveEngine.swift – simple adaptive algorithm tracking performance
│   ├── DoctorPathView.swift – contains doctor‑themed games
│   ├── VetPathView.swift    – contains veterinarian‑themed games
│   ├── PotionPathView.swift – contains potions master‑themed games
│   └── AstronautPathView.swift – contains astronaut‑themed games
├── App/Games/              – subdirectory with individual game views
│   ├── DoctorBandAidGame.swift
│   ├── DoctorCountingGame.swift
│   ├── VetMatchGame.swift
│   ├── VetSizeGame.swift
│   ├── PotionColorMixGame.swift
│   ├── PotionShapeSortGame.swift
│   ├── AstronautCountGame.swift
│   └── AstronautPatternGame.swift
└── Assets/
    ├── cross.png           – watercolor red cross icon
    ├── paw.png             – watercolor paw print icon
    ├── potion.png          – watercolor potion bottle icon
    ├── rocket.png          – watercolor rocket icon
    └── home_background.jpg – optional watercolor background
```

To run the app, open the project in **Xcode** and ensure the images are included in the asset catalog.  The Swift files compile with Xcode 13+ and target iOS 15.  Because this is a prototype, additional features such as login, audio prompts, accessibility support, data persistence, and a polished game selection experience remain to be implemented.

## Contributing

Pull requests are welcome!  If you develop new games or improve the adaptive logic, please ensure they are developmentally appropriate.  Pay attention to accessibility (e.g., VoiceOver support), diversity of characters, and positive, non‑violent feedback.  Refer to the research links in this README for evidence‑based guidelines when designing new activities.
