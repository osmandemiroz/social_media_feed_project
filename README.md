# Social Media Feed App

A Flutter-based social media feed application that allows users to view, create, and interact with posts.

## Features

- View a feed of posts
- Create new posts with text and optional images
- Pagination for loading more posts
- Responsive design for various screen sizes

## Technologies Used

- Flutter
- Dart
- Hive (for local data storage)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- An IDE (e.g., Android Studio, VSCode)

### Installation

1. Clone the repository:
- git clone https://github.com/osmandemiroz/social-media-feed-app.git

2. Navigate to the project directory:
- cd social-media-feed-app

3. Install dependencies:
- flutter pub get

4. Generate Hive adapters:
- flutter packages pub run build_runner build

### Running the App

To run the app in debug mode:
- flutter run 
## Project Structure
lib/

├── main.dart

├── models/
│   └── post.dart

├── screens/
│   ├── feed_screen.dart
│   ├── post_detail_screen.dart
│   └── create_post_screen.dart

├── services/
│   └── post_service.dart

├── utils/
│   └── responsive_sizer.dart

└── widgets/
└── post_card.dart

## Testing

To run the tests:
- flutter test
