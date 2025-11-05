# Sweat and Shine Watch

Apple Watch companion app for the Sweat and Shine fitness tracking web application.

## Overview

This is a watchOS app that syncs with your existing web app through Firebase. It allows you to:
- View current workout exercises on your Apple Watch
- Track series completion
- See rest timers with haptic feedback
- Mark exercises as complete
- All data syncs in real-time with your web app

## Architecture

```
Web App (React) ←→ Firebase Firestore ←→ Watch App (SwiftUI)
```

The Watch app reads workout sessions directly from Firebase and can also be complemented by an iOS bridge app for enhanced connectivity.

## Setup Instructions

### Getting Started

### Prerequisites

- **Xcode 15+** installed on macOS
- **Apple Developer Account** (for deployment to physical Apple Watch)
- **Apple Watch** paired with iPhone
- **Firebase project** (the same one used by your web app)

### Important Notes

⚠️ **USER_ID Configuration**: In the code files `ContentView.swift` and `ExerciseDetailView.swift`, you'll find:
```swift
@State private var userId = "USER_ID_HERE" // TODO: Replace with actual auth
```

You need to replace `"USER_ID_HERE"` with your actual Firebase user ID. For now, you can hardcode it directly, but in production you should implement proper Firebase Authentication.

### Setup Steps

### Step 1: Create Xcode Project

1. Open Xcode
2. Create new project → **watchOS** → **App**
3. Product Name: `SweatWatch`
4. Organization Identifier: `com.yourname.sweatwatch`
5. Interface: **SwiftUI**
6. Life Cycle: **SwiftUI App**
7. Include: **Watch App**
8. Save to: `/Users/yol/Documents/sweat-watch/`

### Step 2: Add Firebase SDK

1. In Xcode, go to **File → Add Package Dependencies**
2. Enter: `https://github.com/firebase/firebase-ios-sdk`
3. Select version: **10.0.0** or later
4. Add packages:
   - FirebaseFirestore
   - FirebaseAuth

### Step 3: Add GoogleService-Info.plist

1. Go to your Firebase Console
2. Add an iOS app (if you haven't)
3. Download `GoogleService-Info.plist`
4. Drag it into your Xcode project (both iOS and Watch targets)

3. **Add Source Files to Xcode Project**
   
   Copy all the Swift files from this repository into your Xcode project:
   
   ```
   SweatWatch Watch App/
   ├── SweatWatchApp.swift (App entry point)
   ├── Views/
   │   ├── ContentView.swift (Main view)
   │   ├── WorkoutView.swift (Active workout display)
   │   ├── ExerciseDetailView.swift (Exercise details & series)
   │   └── RestTimerView.swift (Rest timer with haptics)
   ├── Models/
   │   ├── Exercise.swift (Exercise data model)
   │   ├── SeriesData.swift (Series/set data model)
   │   └── WorkoutSession.swift (Workout session model)
   └── Services/
       └── FirebaseService.swift (Firebase Firestore service)
   ```
   
   In Xcode:
   - Right-click on "SweatWatch Watch App" folder
   - Select "Add Files to SweatWatch..."
   - Select all the Swift files from this repository
   - Make sure "Copy items if needed" is checked
   - Click "Add"

### Step 5: Configure Info.plist

Add to your Watch app's Info.plist:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>workout-processing</string>
</array>
```

### Step 6: Build and Run

1. Select your Apple Watch as the deployment target
2. Click Run (⌘R)

## Project Structure

```
SweatWatch/
├── SweatWatchApp.swift          # App entry point
├── Models/
│   ├── Exercise.swift           # Exercise data model
│   ├── WorkoutSession.swift     # Workout session model
│   └── SeriesData.swift         # Series/set data model
├── Views/
│   ├── ContentView.swift        # Main navigation view
│   ├── WorkoutView.swift        # Active workout display
│   ├── ExerciseDetailView.swift # Current exercise details
│   └── RestTimerView.swift      # Countdown timer
├── Services/
│   └── FirebaseService.swift    # Firebase connection
└── GoogleService-Info.plist     # Firebase config
```

## Color Palette

The app uses your brand colors:
- Mint Green: `#b5ffe9`
- Sea Green: `#c5e0d8`
- Dusty Rose: `#ceabb1`
- Gray: `#c9c9c9`
- Dark Gray: `#444545`

## Features

### Core Features
- ✅ Real-time workout sync from Firebase
- ✅ Exercise list with current workout
- ✅ Series tracking with checkmarks
- ✅ Rest timer with haptic feedback
- ✅ Progress indicators
- ✅ Digital Crown navigation

### Future Enhancements
- Heart rate monitoring integration
- Calorie tracking
- Workout history on Watch
- Complications for Watch face
- Standalone Watch app (no iPhone needed)

## Troubleshooting

### Firebase Connection Issues
- Ensure `GoogleService-Info.plist` is added to Watch target
- Check Firebase console for proper iOS app configuration
- Verify bundle identifier matches

### Watch Not Appearing
- Ensure Apple Watch is paired with iPhone
- Check that watchOS 10+ is installed
- Enable Developer Mode on Watch (Settings → Privacy & Security)

## Development Notes

- Uses SwiftUI for all UI components
- Firebase SDK handles real-time updates
- Watch Connectivity framework ready for iOS bridge
- Designed for Always-On display optimization

## Support

For issues or questions, refer to:
- Firebase iOS SDK: https://firebase.google.com/docs/ios/setup
- watchOS Development: https://developer.apple.com/watchos/
