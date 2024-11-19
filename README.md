# Task Planner 🚀  

A simple, intuitive **To-Do** application built with Flutter, following **Clean Architecture** principles and designed to help developers learn and practice best coding standards. This project serves as a resource for exploring architectural patterns, efficient state management, and Flutter development best practices.  

---

## ✨ Features  

- **Clean Architecture** 🏗️  
  Organized structure that separates concerns and promotes scalability and maintainability.  

- **State Management with Bloc** 🔄  
  Efficient and sustainable state management using the Bloc pattern.  

- **CI/CD Automation** 🤖  
  Automated workflows with **GitHub Actions** for testing and building.  

- **Dependency Injection** 🧩  
  Dependency management with [Get It](https://pub.dev/packages/get_it), ensuring a modular and decoupled codebase.  

- **Transition Animations** 🎨  
  Smooth and engaging animations for a better user experience.  

- **Comprehensive Testing** 🧪  
  - **Unit & Widget Testing** to ensure code reliability.  
  - **Integration Testing** to validate end-to-end behavior.  

- **Local Storage** 🗂️  
  Data persistence using [Shared Preferences](https://pub.dev/packages/shared_preferences).  

- **Internationalization (i18n)** 🌍  
  Multiple language support using [Intl](https://pub.dev/packages/intl) for dynamic content translation.  

- **Sensitive Data Protection** 🔐  
  API keys and sensitive variables are secured using [envied](https://pub.dev/packages/envied).  

- **Firebase Crashlytics** 🔥  
  Real-time monitoring and error reporting with **Firebase Crashlytics**.  

---

## 🛠️ Technologies  

- **Language**: Dart  
- **Framework**: Flutter  
- **State Management**: Bloc  
- **Local Storage**: Shared Preferences  
- **Internationalization**: Intl  
- **Automation**: GitHub Actions  
- **Dependency Injection**: Get It  
- **Data Protection**: envied  
- **Crash Reports**: Firebase Crashlytics  

---

## 📂 Project Structure  

The app follows **Clean Architecture** principles, dividing the code into layers:  

1. **Data Layer**  
   - Handles data sources, models, and repositories.  
2. **Domain Layer**  
   - Contains business logic and use cases.  
3. **Presentation Layer**  
   - UI components, Bloc implementations, and widgets.  

---

## 🌟 Why this project?  

This project was designed as a learning sandbox, focusing on:  
- Applying Clean Architecture principles in Flutter.  
- Implementing coding best practices, such as comprehensive testing and efficient state management.  
- Automating CI/CD processes.  
- Exploring essential tools for modern app development.  
- Adding internationalization support for a global audience.  

---

## 🎥 Demo  

<video src="https://github.com/user-attachments/assets/581cc498-ed24-4609-8e32-ef6d85331f05" />


---

## 🚀 How to Run the Project  

1. Clone the repository:  
   `git clone https://github.com/your-username/task-planner.git`  

2. Navigate to the project directory:  
   `cd task-planner`  

3. Install dependencies:  
   `flutter pub get`  

4. Set up environment variables:  
   Create a `.env` file in the project root and add your API keys as required by [envied](https://pub.dev/packages/envied).  

5. Set up supported languages for internationalization:  
   Add the necessary translations in `.arb` files under the `lib/l10n/` directory, following the [Intl](https://pub.dev/packages/intl) package documentation.  

6. Run the application:  
   `flutter run`

Feel free to contribute and explore this project with me! 💡

