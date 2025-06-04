# proj_bloc

A Flutter application built with clean architecture and the BLoC pattern, integrating the [DummyJSON API](https://dummyjson.com/) to demonstrate advanced user management features.

🧱 Architecture Overview
Presentation Layer: Uses flutter_bloc for stateful widgets and reactive UIs.

Domain Layer: Business logic handled in BLoC classes, events & states.

Data Layer: Network calls are abstracted into a UserRepository.

Model Layer: UserModel, PostModel, ToDoModel for decoding JSON responses.
![image](https://github.com/user-attachments/assets/016731ce-e22d-49c3-a52f-084fa554bfc9)

https://drive.google.com/file/d/1z-pi0YdGTt9GJepqERlI7_6_OSOuAjVQ/view?usp=drive_link


📱 Features
1. API Integration
Integrates DummyJSON Users, Posts, and Todos API with pagination and search.

2. State Management (BLoC)
Manages UI state using flutter_bloc with events like fetch, search, and pagination.

3. UI Features
Displays user list, user detail (posts & todos), search bar, and post creation screen.

4. Code Quality & Architecture
Clean BLoC-based architecture with proper folder structure and error handling.

🌗 Bonus Features
Supports light/dark theme switching and responsive layout.


🛠️ Setup Instructions
1. Clone the repo:
   git clone https://github.com/yourusername/flutter-user-management-app.git
   cd flutter-user-management-app

2. Install dependencies:
   flutter pub get
3. Run the app:
   flutter run
   



