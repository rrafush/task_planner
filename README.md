# Task Planner

A simple and intuitive To-Do application built with Flutter, following Clean Architecture principles and designed for learning and practicing best coding standards. This app serves as a learning resource to explore architectural patterns, effective state management, and good practices in Flutter development.

## Features

- **Clean Architecture**: Organized structure that separates concerns and promotes scalability.
- **State Management with Bloc**: Utilizes the Bloc pattern for effective and maintainable state management.
- **CI/CD**: Automated workflows with GitHub Actions for testing and building.
- **Dependency Injection**: Manages dependencies with [Get It](https://pub.dev/packages/get_it) for clean, decoupled code.
- **Unit & Widget Testing**: Comprehensive tests to ensure code reliability.
- **Local Storage**: Stores data locally using [Shared Preferences](https://pub.dev/packages/shared_preferences).

## Project Structure

The app is built with Clean Architecture, organized into layers:
- **Data Layer**: Handles data sources, models, and repositories.
- **Domain Layer**: Contains the business logic and use cases.
- **Presentation Layer**: UI components, Bloc implementations, and widgets.
