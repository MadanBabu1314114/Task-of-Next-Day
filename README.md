# Task of Next Day

Modern Flutter App: Paginated User List with Favorites, Glassmorphism, and Animated Background

## Features

- Fetches users from [ReqRes API](https://reqres.in/api/users?page=2) with pagination
- Beautiful glassy (glassmorphism) cards with blur and shadow
- Animated, color-changing gradient background (main and favorites screens)
- Favorite/unfavorite users with persistent local storage (Shared Preferences)
- Separate favorites screen with same modern UI
- Smooth slide and fade-in animations for list items
- Hero animation for user avatars
- Responsive and high-performance UI

## Screenshots


https://github.com/user-attachments/assets/f2fb413f-15de-4d07-9a35-7f07c7a72120


 

## Getting Started

1. **Install dependencies:**
   ```sh
   flutter pub get
   ```
2. **Run the app:**
   ```sh
   flutter run
   ```
3. **Build APK:**
   ```sh
   flutter build apk --release
   ```

## Project Structure

- `lib/main.dart` - App entry, animated background, theme
- `lib/models/user.dart` - User model
- `lib/providers/user_provider.dart` - State management, API, favorites
- `lib/screens/home_screen.dart` - Main user list
- `lib/screens/favorites_screen.dart` - Favorites list
- `lib/widgets/user_list_item.dart` - Glassy user card with Hero
- `lib/widgets/animated_list_view.dart` - Animated list with loading

## API

Uses [ReqRes](https://reqres.in/) for paginated user data:
```
GET https://reqres.in/api/users?page=1
```

## Glassmorphism & Animations

- Cards use `BackdropFilter` for blur, semi-transparent backgrounds, and soft borders/shadows
- Animated gradient background cycles through colors
- List items fade and slide in
- Hero animation for avatar images

## Local Storage

Favorites are saved using `shared_preferences` and persist across app restarts.

## Customization

- Change gradient colors in `main.dart`
- Adjust blur, border, and shadow in `user_list_item.dart`

---

**Made with Flutter 3.8+**
