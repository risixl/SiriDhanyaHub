# 🌾 Siri-Dhanya Hub

> A cross-platform Flutter application digitally supporting Karnataka's millet ecosystem — connecting **consumers, farmers, and Farmer Producer Organizations (FPOs)** through a single, unified platform.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Material Design 3](https://img.shields.io/badge/Material%20Design%203-757575?style=for-the-badge&logo=materialdesign&logoColor=white)](https://m3.material.io/)
[![Platform](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-blue?style=for-the-badge)]()
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)]()

---

## 📖 Table of Contents

- [About the Project](#-about-the-project)
- [Problem Statement](#-problem-statement)
- [Key Features](#-key-features)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Getting Started](#-getting-started)
- [Dependencies](#-dependencies)
- [Design Approach](#-design-approach)
- [Supported Millet Varieties](#-supported-millet-varieties)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [Author](#-author)
- [Acknowledgements](#-acknowledgements)
- [License](#-license)

---

## 🌱 About the Project

**Siri-Dhanya Hub** is a cross-platform mobile application built with **Flutter** that promotes Karnataka's traditional millet ecosystem. Millets are highly nutritious, climate-resilient crops gaining national importance, yet public awareness around varieties, mandi prices, traditional recipes, and direct farmer connectivity remains limited.

This app brings together four core functionalities — **market price tracking, traditional recipes, health awareness, and FPO connectivity** — into one accessible mobile experience designed for consumers, health-conscious users, farmers, and Farmer Producer Organizations.

> Developed as part of an Android App Development internship at **MindMatrix.io**.

---

## 🎯 Problem Statement

Farmers and consumers in the millet ecosystem face several challenges:

- ❌ Lack of centralized, real-time **market price** information
- ❌ Limited awareness of **millet health benefits** and nutritional value
- ❌ Reduced visibility of **traditional millet recipes**
- ❌ Difficulty connecting directly with **Farmer Producer Organizations (FPOs)**
- ❌ Existing apps focus only on crop trading, ignoring education and nutrition

**Siri-Dhanya Hub** solves these gaps by providing an integrated platform for price tracking, recipe discovery, nutritional awareness, and direct farmer-consumer interaction — all in a single app.

---

## ✨ Key Features

### 🏠 Dashboard Home
A clean landing screen displaying featured millet information, quick navigation, and highlighted content using responsive **card-based layouts**.

### 📈 Mandi Watch
- Tracks millet market prices across **five Karnataka cities** (Bengaluru, Davangere, Mysuru, Hubli, Shivamogga)
- Displays **7-day historical price trends**
- Graphical **sparkline visualizations** powered by `fl_chart`
- City and millet filtering with live update indicators

### 🍲 Recipe Lab
- Traditional millet recipes with **ingredients & preparation steps**
- **Category-based filtering** (by millet type, difficulty, dietary tags)
- **Search** by millet type or dish name
- **Bookmark** favorite recipes (persisted via `SharedPreferences`)
- Tags like *Diabetic Friendly*, *High Fibre*, *Gluten Free*, *Vegan*, *High Protein*

### ❤️ Health Benefits
- Nutritional values and health benefits for each millet variety
- **Glycemic Index Comparison** chart
- Expandable cards for each millet (Navane, Sajje, Baragu, Ragi, Oodalu, Saame)

### 🛒 Direct Buy — FPO Directory
- Browse regional **Farmer Producer Organizations** with contact info
- View FPO ratings, farmer counts, and specializations
- **Direct call** and **Buy Direct** action buttons — cutting out middlemen
- Filter FPOs by millet type

### 🎨 Additional UX Features
- ✅ Pull-to-refresh on all data screens
- ✅ Smooth bottom navigation across 5 sections
- ✅ Responsive layouts for phone, tablet, web, and desktop
- ✅ Earthy, agriculture-inspired visual theme

---

## 📱 Screenshots

| Mandi Watch | Recipe Lab |
|:---:|:---:|
| Real-time millet prices with sparklines | Traditional recipes with category filters |

| Health Benefits | Direct Buy (FPO Directory) |
|:---:|:---:|
| Nutritional info & glycemic index | Connect directly with regional FPOs |

> 📸 Add screenshots to `assets/screenshots/` and reference them here, e.g.:
> `![Mandi Watch](assets/screenshots/mandi_watch.png)`

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter |
| **Language** | Dart |
| **State Management** | Provider |
| **Local Storage** | SharedPreferences |
| **UI System** | Material Design 3 |
| **Charts** | fl_chart |
| **Typography** | Playfair Display (headings), Nunito (body) |
| **Architecture** | Modular Multi-Screen Architecture |
| **Target Platforms** | Android, iOS, Web, Windows, Linux, macOS |

---

## 🏗 Architecture

Siri-Dhanya Hub follows a **modular multi-screen architecture** with clean separation of concerns:

```
┌─────────────────────────────────────────┐
│              UI Layer                   │
│      (Screens + Reusable Widgets)       │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│         State Management Layer          │
│        (Provider / ChangeNotifier)      │
└────────────────┬────────────────────────┘
                 │
┌────────────────▼────────────────────────┐
│           Data Layer                    │
│  (Models + Seed Data + SharedPrefs)     │
└─────────────────────────────────────────┘
```

**Layers:**
- **Models** — Strongly typed Dart classes for Millets, Recipes, Prices, FPOs
- **Providers** — State containers (e.g. `RecipeProvider`, `PriceProvider`, `BookmarkProvider`)
- **Screens** — Top-level routes (Home, Mandi, Recipes, Health, Buy)
- **Widgets** — Reusable components (cards, charts, filters)
- **Theme** — Centralized colors, typography, spacing

---

## 📁 Project Structure

```
siri_dhanya_hub/
├── android/                  # Android-specific code
├── ios/                      # iOS-specific code
├── web/                      # Web build configuration
├── windows/ macos/ linux/    # Desktop platform code
├── assets/
│   ├── images/              # Millet illustrations & icons
│   ├── fonts/               # Playfair Display, Nunito
│   └── screenshots/         # README screenshots
├── lib/
│   ├── main.dart            # App entry point
│   ├── models/              # Data models
│   │   ├── millet.dart
│   │   ├── recipe.dart
│   │   ├── price_data.dart
│   │   └── fpo.dart
│   ├── providers/           # State management
│   │   ├── recipe_provider.dart
│   │   ├── price_provider.dart
│   │   └── bookmark_provider.dart
│   ├── screens/             # App screens
│   │   ├── home_screen.dart
│   │   ├── mandi_watch_screen.dart
│   │   ├── recipe_lab_screen.dart
│   │   ├── health_benefits_screen.dart
│   │   └── direct_buy_screen.dart
│   ├── widgets/             # Reusable UI components
│   │   ├── millet_card.dart
│   │   ├── price_sparkline.dart
│   │   ├── recipe_tile.dart
│   │   └── fpo_card.dart
│   ├── data/                # Seed data
│   │   ├── millet_data.dart
│   │   ├── recipe_data.dart
│   │   └── fpo_data.dart
│   └── theme/               # App theming
│       ├── app_colors.dart
│       ├── app_typography.dart
│       └── app_theme.dart
├── test/                    # Unit & widget tests
├── pubspec.yaml             # Project dependencies
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have the following installed:

- **Flutter SDK** (≥ 3.0.0) — [Install guide](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (bundled with Flutter)
- **Android Studio** or **VS Code** with the Flutter plugin
- **Git**

Verify your setup:
```bash
flutter doctor
```

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/risixl/SiriDhanyaHub.git
   cd SiriDhanyaHub/siri_dhanya_hub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Run on connected device or emulator
   flutter run

   # Run on a specific platform
   flutter run -d chrome      # Web
   flutter run -d windows     # Windows
   flutter run -d macos       # macOS
   ```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release

# Windows / macOS / Linux
flutter build windows
flutter build macos
flutter build linux
```

---

## 📦 Dependencies

Key packages used in this project (see `pubspec.yaml` for the full list):

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1            # State management
  shared_preferences: ^2.2.2  # Local persistence (bookmarks)
  fl_chart: ^0.66.0           # Price trend sparklines
  google_fonts: ^6.1.0        # Playfair Display & Nunito
  cupertino_icons: ^1.0.6
```

Install them with:
```bash
flutter pub get
```

---

## 🎨 Design Approach

The visual identity reflects Karnataka's traditional farming culture:

- 🌾 **Parchment-style backgrounds** for an earthy, warm feel
- 🌿 **Millet-green accent colors** as the primary brand hue
- ✍️ **Playfair Display** for headings — gives a traditional, editorial tone
- 📖 **Nunito** for body text — modern, highly legible
- 📐 **Material Design 3** components for consistency and accessibility
- 📱 **Responsive layouts** adapting from phone → tablet → desktop

---

## 🌾 Supported Millet Varieties

| Local Name | English Name | Highlight |
|---|---|---|
| **Navane** | Foxtail Millet | Controls blood sugar |
| **Sajje** | Pearl Millet | Powers your energy |
| **Baragu** | Proso Millet | Heart-healthy grain |
| **Ragi** | Finger Millet | Nature's calcium bank |
| **Oodalu** | Barnyard Millet | High fibre, gluten-free |
| **Saame** | Little Millet | Aids weight management |

---

## 🗺 Roadmap

- [x] Dashboard home screen
- [x] Mandi Watch with 7-day price trends
- [x] Recipe Lab with bookmarking
- [x] Health Benefits with glycemic index comparison
- [x] FPO Directory with direct contact
- [ ] **Live price API integration** (currently uses seed data)
- [ ] **Multi-language support** (Kannada, Hindi, English)
- [ ] **User authentication** via Firebase Auth
- [ ] **FPO order placement & tracking**
- [ ] **AI-powered recipe suggestions** based on available ingredients
- [ ] **Push notifications** for price alerts
- [ ] **Dark mode** support

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 👩‍💻 Author

**Riya Singh**
- 🎓 B.E. in Computer Science & Engineering, CMR Institute of Technology
- 💼 Android Developer Intern @ MindMatrix.io
- 🔗 GitHub: [@risixl](https://github.com/risixl)

---

## 🙏 Acknowledgements

This project was developed during my internship at **[MindMatrix.io](https://mindmatrix.io)** (a product of CL Infotech Pvt. Ltd.) through the VTU Internship Portal.

Special thanks to:

- **Prof. Priti Badar** — Assistant Professor, Dept. of CSE, CMRIT (Internship Guide)
- **Dr. Prem Kumar Ramesh** — HOD, Dept. of CSE, CMRIT
- **MindMatrix mentors** — for technical guidance throughout the program
- The **Flutter** and **Dart** open-source communities

### References

- [Android Basics with Compose – Google](https://developer.android.com/courses/android-basics-compose/course)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [fl_chart package](https://pub.dev/packages/fl_chart)
- [Provider package](https://pub.dev/packages/provider)

---

## 📄 License

Distributed under the **MIT License**. See `LICENSE` for more information.

```
MIT License

Copyright (c) 2026 Riya Singh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

<div align="center">

### 🌾 Made with ❤️ for Karnataka's farmers and millet ecosystem 🌾

⭐ **If you found this project useful, please consider giving it a star!** ⭐

</div>
