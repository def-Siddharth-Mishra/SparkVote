# 🚀 Startup Idea Evaluator – AI + Voting App

An interactive mobile app that allows users to submit startup ideas, receive fun fake AI ratings, vote on ideas, and view a leaderboard of the top-rated or most-voted ideas.

## 🧑‍💻 Tech Stack Used

- **Framework**: Flutter (Dart)
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Fonts**: Google Fonts
- **Unique IDs**: uuid
- **Sharing**: share_plus

## 📱 Features Implemented

### ✅ 1. Idea Submission Screen
- **Input fields**: Startup Name, Tagline, Description
- **On submit**:
  - Generates a fake AI rating (0–100)
  - Saves idea data locally using SharedPreferences
  - Navigates to the Idea Listing screen
  - Shows toast notification for successful submission

### 📜 2. Idea Listing Screen
- **Displays all submitted ideas**:
  - Name, tagline, AI rating, vote count
  - "Upvote" button (one vote per idea using local persistence)
  - "Read More" option to expand full description
  - **Sorting options**: by votes or rating
  - Pull-to-refresh functionality

### 🏆 3. Leaderboard Screen
- **Top 5 ideas** based on votes or ratings
- **UI elements**:
  - 🥇🥈🥉 medals for top 3 positions
  - Stylish cards with gradients and shadows
  - Animated transitions between screens

### 🌚 4. Bonus Features
- **Dark mode toggle** with persistent theme preference
- **Toast notifications** on idea submission and voting
- **Share ideas** via clipboard/social apps using share_plus
- **Swipe animations** and smooth transitions
- **Custom fonts** via Google Fonts
- **Responsive design** for different screen sizes

## 🛠️ How to Run Locally

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / Xcode (for mobile development)

### Clone the repository
```bash
git clone https://github.com/your-username/startup-idea-evaluator.git
cd startup-idea-evaluator
```

### Install dependencies
```bash
flutter pub get
```

### Configure Android
Ensure you have the correct permissions in `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```

### Run the app
```bash
# For Android
flutter run

# For iOS
flutter run

# For web
flutter run -d chrome
```

### Build APK for sharing
```bash
flutter build apk --release
```
The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

## 🚀 Deployment & Submission

### Sharing Options
1. **Debug APK**: Share via Google Drive or WeTransfer
2. **GitHub Releases**: Upload APK to GitHub releases
3. **Firebase App Distribution**: For testing with specific users

### Submission Checklist
- [ ] App source code (GitHub repository)
- [ ] APK download link or file
- [ ] README file (this file)
- [ ] Short Loom/YouTube video walkthrough (2–3 minutes)

## 📁 Project Structure
```
lib/
├── core/
│   └── utils/
│       └── app_constants.dart
├── data/
│   ├── datasources/
│   │   └── local_storage_service.dart
│   └── repositories/
│       └── idea_repository_impl.dart
├── domain/
│   ├── models/
│   │   └── idea_model.dart
│   └── repositories/
│       └── idea_repository.dart
└── presentation/
    ├── providers/
    │   ├── idea_provider.dart
    │   └── theme_provider.dart
    ├── screens/
    │   ├── home_screen.dart
    │   ├── idea_submission_screen.dart
    │   └── leaderboard_screen.dart
    └── widgets/
        ├── idea_card.dart
        └── theme_switch.dart
```

## 🎯 Key Design Decisions

- **Provider for State Management**: Lightweight and efficient for this scale
- **SharedPreferences for Local Storage**: Simple and reliable for small data
- **Clean Architecture**: Separation of concerns with domain-driven design
- **Responsive UI**: Works on phones and tablets
- **Dark Mode**: System preference detection with manual override

## 🐛 Troubleshooting

### Common Issues
1. **Build fails**: Run `flutter clean` then `flutter pub get`
2. **Android license issues**: Run `flutter doctor --android-licenses`
3. **iOS deployment issues**: Run `cd ios && pod install`

### Getting Help
- Check Flutter doctor: `flutter doctor -v`
- View logs: `flutter logs`
- Debug mode: Run with `flutter run --debug`

## 📞 Contact

For questions or support regarding this assignment, please contact:
- GitHub Issues: [Create an issue](https://github.com/your-username/startup-idea-evaluator/issues)
- Email: [siddharthmishra918@gmail.com]

---

**⏰ Deadline**: You have 4 days from the day you applied.

**Good luck with your submission! 🎉**
