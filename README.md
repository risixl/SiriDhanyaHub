# Siri-Dhanya Hub

A cross-platform Flutter application digitally supporting Karnataka's millet ecosystem by connecting consumers, farmers, and Farmer Producer Organizations (FPOs) through a unified platform.

## About the Project

Siri-Dhanya Hub is a cross-platform mobile application built with Flutter that promotes Karnataka's traditional millet ecosystem. Millets are highly nutritious and climate-resilient crops, yet public awareness regarding millet varieties, market prices, traditional recipes, and direct farmer connectivity remains limited.

The application combines four core functionalities into a single platform:

- Market Price Tracking
- Traditional Millet Recipes
- Health and Nutrition Awareness
- Farmer Producer Organization (FPO) Connectivity

Developed as part of an Android App Development Internship at MindMatrix.io.

## Problem Statement

Farmers and consumers within the millet ecosystem face multiple challenges:

- Lack of centralized market price information
- Limited awareness of millet health benefits
- Reduced visibility of traditional millet recipes
- Difficulty connecting directly with Farmer Producer Organizations
- Existing applications focus mainly on crop trading and ignore education and nutrition

Siri-Dhanya Hub addresses these challenges by providing an integrated platform for price tracking, recipe discovery, nutritional awareness, and direct farmer-consumer interaction.

## Key Features

### Dashboard Home

- Kannada welcome greeting
- Quick Access cards for all modules
- "Why Millets?" information section
- Highlights environmental and health benefits of millets

### Mandi Watch

- Tracks millet prices across:
  - Bengaluru
  - Davangere
  - Mysuru
  - Hubli
  - Shivamogga
- Displays:
  - Current price
  - Percentage change
  - Daily high/low
- Sparkline trend charts using fl_chart

### Recipe Lab

- Traditional millet recipes in English and Kannada
- Recipe information:
  - Cooking time
  - Servings
  - Difficulty level
- Search and filter functionality
- Bookmark recipes using SharedPreferences
- Nutritional tags and health indicators

### Health Benefits

- Nutritional information for millet varieties
- Glycemic Index comparison charts
- Detailed health benefits for each millet type

### Direct Buy – FPO Directory

- Browse Farmer Producer Organizations
- View:
  - Contact information
  - Ratings
  - Farmer count
  - Certifications
- Direct call functionality
- Direct purchase support

### Additional Features

- Pull-to-refresh support
- Bottom navigation system
- Responsive layouts
- Material Design 3 interface

## Tech Stack

| Layer | Technology |
|---------|------------|
| Framework | Flutter |
| Language | Dart |
| State Management | Provider |
| Local Storage | SharedPreferences |
| UI System | Material Design 3 |
| Charts | fl_chart |
| Typography | Playfair Display, Nunito |
| Architecture | Modular Multi-Screen Architecture |
| Platforms | Android, iOS, Web, Windows, macOS, Linux |

## Architecture

UI Layer
- Screens
- Reusable Widgets

State Management Layer
- Provider
- ChangeNotifier

Data Layer
- Models
- Seed Data
- SharedPreferences

## Supported Millet Varieties

| Local Name | English Name | Benefit |
|------------|-------------|----------|
| Navane | Foxtail Millet | Controls blood sugar |
| Sajje | Pearl Millet | Energy source |
| Baragu | Proso Millet | Heart health |
| Ragi | Finger Millet | Rich in calcium |
| Oodalu | Barnyard Millet | High fibre |
| Saame | Little Millet | Weight management |

## Future Enhancements

- Live market price API integration
- Multi-language support
- Firebase Authentication
- FPO order placement and tracking
- AI-based recipe recommendations
- Push notifications for price alerts
- Dark mode support

## Author

Riya Singh

- B.E. Computer Science and Engineering
- CMR Institute of Technology
- Android Developer Intern at MindMatrix.io
- GitHub: https://github.com/risixl

## Acknowledgements

This project was developed during an internship at MindMatrix.io through the VTU Internship Portal.

Special thanks to:

- Prof. Priti Badar, Assistant Professor, CMRIT
- Dr. Prem Kumar Ramesh, Head of Department, CMRIT
- MindMatrix Mentors
- Flutter and Dart Open Source Communities

## License

MIT License
