# Shop Plants App

A Flutter application for browsing and purchasing plants, discovering services, and finding store locations. This project follows a modular and clean code architecture.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Flutter SDK**: Installed and configured (version 3.0.0 or higher recommended).
- **Dart SDK**: Included with Flutter.
- **IDE**: VS Code (recommended) or Android Studio.
- **Emulator/Device**: Android Emulator, iOS Simulator (macOS only), or a physical device connected via USB.

## Installation

1.  **Clone the repository** (if applicable) or navigate to the project directory:
    ```bash
    cd c:\Users\User\Development\ShopPlane\shop_plants
    ```

2.  **Install dependencies**:
    Run the following command to fetch all required packages listed in `pubspec.yaml`:
    ```bash
    flutter pub get
    ```

## Running the App

To run the application on your connected device or emulator:

1.  **Launch your Emulator** or connect your physical device.
2.  **Run the command**:
    ```bash
    flutter run
    ```

### Platform Specifics

-   **Android/iOS**: The app is optimized for mobile devices.
-   **Web**: Run `flutter run -d chrome` to view in the browser.
-   **Windows**: Run `flutter run -d windows` to view as a desktop application.

## Project Structure

The project is organized into modules for better scalability and maintenance:

```
lib/
├── src/
│   ├── core/           # Core utilities, themes (AppColors), and shared logic
│   ├── data/           # Data layer (Models, Repositories)
│   ├── modules/        # Feature-based modules (Home, Shop, Mall, etc.)
│   │   ├── home/       # Home screen and its widgets
│   │   ├── mall/       # Mall screen and its widgets
│   │   ├── shop/       # Shop screen and its widgets
│   │   ├── services/   # Services screen and its widgets
│   │   └── components/ # Shared UI components (BottomNavBar, Cards)
│   └── main.dart       # Entry point of the application
└── assets/             # Images and data files
```

## Features

-   **Home Screen**: Featured plants, trending items, and store location with map integration.
-   **Mall Screen**: Grid view of items with discounts and search functionality.
-   **Shop Screen**: Browsing available plants.
-   **Services Screen**: List of available plant care services.
-   **Clean Architecture**: Modular code structure for easy maintenance.

## Troubleshooting

-   **Dependencies Error**: If you encounter issues with packages, try running `flutter clean` followed by `flutter pub get`.
-   **Device Not Found**: Ensure your device is connected and USB debugging is enabled (for Android), or your simulator is running. Check with `flutter devices`.
