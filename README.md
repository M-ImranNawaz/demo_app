# Digital Health App

A Flutter-based check-in application with Firebase integration and BLoC state management. The app provides daily check-in functionality with a smooth, user-friendly UI, and features login, signup, logout, and a history view for check-ins.

---
## App Demo

Screenrecording:   - `https://youtu.be/HQva721EWCU`

## Getting Started

### Prerequisites

Ensure you have Flutter and Dart SDK installed.

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/M-ImranNawaz/demo_app

2. **Navigate to Project Directory**
   ```bash
   cd demo_app
   
3. **Install Dependencies**
   ```bash
   flutter pub get
   
4. **Run the App**
   ```bash
   flutter run

## Project Structure

The project follows a clean code structure and the BLoC pattern for state management, ensuring modularity, reusability, and readability.

- **Widgets**: Contains reusable UI components. e.g.
  - `lib/views/widgets/primary_button.dart`: Primary button widget for uniform styling.
  
- **Utils**: Utility functions and helper widgets.
  
- **Resources** (`res`): Stores app resources.
  - **App Styles** (`lib/utils/res/styles`): Colors, text styles, and themes.
  - **App Strings** (`lib/utils/res/strings`): Static text used throughout the app, supporting localization.
  
- **BLoC Pattern**: Business logic components are organized in the `bloc` folder, providing clean and consistent state management.

---

## Extra Features

- **Signup, Logout**: Firebase Auth-based authentication with persistent user sessions.
- **Check-in Data**: Allows users to log daily check-ins, which are viewable on the main screen.
- **Awesome UI**: Clean and intuitive UI with smooth navigation and visually appealing layout.

---

## Reach out to me

email:   - `imrannawaz288@gmail.com`

slack:   - `imrannawaz288@gmail.com`

linkedIn - `https://www.linkedin.com/in/imran-nawaz-appdev/`

StackOverflow - `https://stackoverflow.com/users/12578631/imran-nawaz`
