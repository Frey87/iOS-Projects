# IBM Developing iOS Apps with Swift Specialization

This repository contains the applications developed during the three-course **Developing iOS Apps with Swift Specialization** offered by **IBM on Coursera**.

The projects demonstrate progressive iOS development skills, beginning with essential SwiftUI interface patterns and advancing to multi-screen applications that integrate networking, maps, local persistence, charts, location services, animations, accessibility, and AI-assisted features.

## Specialization overview

The specialization focuses on designing and building modern iOS applications with Swift, SwiftUI, Xcode, and Apple frameworks. Each course includes practical development work, while the final capstone combines the main concepts into a portfolio-ready application.

| Item               | Information                                 |
| ------------------ | ------------------------------------------- |
| **Provider**       | IBM                                         |
| **Platform**       | Coursera                                    |
| **Specialization** | Developing iOS Apps with Swift              |
| **Courses**        | 3                                           |
| **Level**          | Beginner                                    |
| **Language**       | English                                     |
| **Main tools**     | Swift, SwiftUI, Xcode, and Apple frameworks |

## Courses and projects

| Course                                                                              | Final project             | Main concepts                                                                                                           |
| ----------------------------------------------------------------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| [1. Get Started with iOS App Development](01-Get-Started-with-iOS-App-Development/) | **Recipe App**            | SwiftUI layouts, navigation, lists, live search, bindings, favorites, and asynchronous images                           |
| [2. Creating iOS Apps Using Swift](02-Creating-iOS-Apps-Using-Swift/)               | **Local Events Explorer** | MVVM, async networking, MapKit, SwiftData, Charts, animations, location, and Foundation Models                          |
| [3. iOS Development Capstone Project](03-iOS-Development-Capstone-Project/)         | **Smart Travel Journal**  | Complete app architecture, persistence, maps, weather data, photographs, charts, accessibility, and AI-assisted content |

## Project progression

### 1. Recipe App

The first project introduces the foundations of building a multi-screen application entirely with SwiftUI.

Key functionality includes:

* Displaying recipes in a scrollable list
* Loading remote images with `AsyncImage`
* Filtering recipes in real time with `.searchable()`
* Navigating between list and detail screens
* Managing favorite status with `@State` and `@Binding`
* Creating reusable SwiftUI views
* Using `#Preview` for interface development

### 2. Local Events Explorer

The second project expands the application architecture and integrates multiple Apple frameworks in a production-style event discovery application.

Key functionality includes:

* Fetching and decoding remote JSON data
* Managing application logic with MVVM and `@Observable`
* Searching events by city
* Displaying event locations with MapKit annotations
* Switching between multiple map styles
* Saving favorite events with SwiftData
* Visualizing ticket prices with Swift Charts
* Generating event recommendations with Foundation Models
* Implementing loading, retry, and error states
* Adding staggered animations and transitions

### 3. Smart Travel Journal

The capstone project brings together the specialization’s major concepts in a complete travel-journaling application.

Key functionality includes:

* Creating and organizing trips and journal entries
* Persisting user-created data with SwiftData
* Managing photographs and travel reflections
* Displaying destinations and locations with MapKit
* Accessing location services through Core Location
* Retrieving weather information asynchronously
* Visualizing travel information with Swift Charts
* Generating AI-assisted trip summaries and tags
* Applying accessibility practices and responsive design
* Organizing the codebase using MVVM

## Skills demonstrated

### Swift and application development

* Swift programming fundamentals
* Data modeling with structures and classes
* Optionals, collections, functions, and error handling
* Asynchronous programming with `async/await`
* JSON decoding with Codable
* Reusable and maintainable application components

### SwiftUI and UI/UX

* Declarative interface development
* `NavigationStack` and `NavigationLink`
* `TabView`, `List`, `ForEach`, and adaptive grids
* `HStack`, `VStack`, and reusable view composition
* State management with `@State`, `@Binding`, and Observation
* Search, animations, transitions, and SF Symbols
* Accessibility labels and scalable interface elements
* Apple Human Interface Guidelines

### Architecture and data

* Model–View–ViewModel architecture
* SwiftData persistence and queries
* Relationships between stored models
* Networking and response validation
* Loading, empty, success, and error states
* Separation of models, views, view models, and services

### Apple frameworks

* SwiftUI
* SwiftData
* MapKit
* Core Location
* Swift Charts
* Foundation Models
* URLSession
* Photos and asset management

## Repository structure

```text
IBM-Developing-iOS-Apps-with-Swift/
├── README.md
├── 01-Get-Started-with-iOS-App-Development/
│   └── Recipe-App/
│       ├── README.md
│       └── RecipeApp.xcodeproj
├── 02-Creating-iOS-Apps-Using-Swift/
│   ├── README.md
│   └── LocalEventsExplorer/
│       └── LocalEventsExplorer.xcodeproj
└── 03-iOS-Development-Capstone-Project/
    ├── README.md
    └── SmartTravelJournal/
        └── SmartTravelJournal.xcodeproj
```

Individual course folders contain more detailed project documentation, feature descriptions, requirements, verification checklists, and screenshots.

## Technologies

| Category                    | Technologies                               |
| --------------------------- | ------------------------------------------ |
| **Language**                | Swift                                      |
| **Interface**               | SwiftUI                                    |
| **Development environment** | Xcode and iOS Simulator                    |
| **Architecture**            | MVVM                                       |
| **Persistence**             | SwiftData                                  |
| **Networking**              | URLSession, Codable, and Swift concurrency |
| **Maps and location**       | MapKit and Core Location                   |
| **Visualization**           | Swift Charts                               |
| **AI**                      | Apple Foundation Models                    |
| **Version control**         | Git and GitHub                             |

## Running a project

1. Clone or download this repository.
2. Open the folder for the required course and project.
3. Open the corresponding `.xcodeproj` file in Xcode.
4. Select a compatible iPhone Simulator or physical device.
5. Review signing settings when using a physical device.
6. Build and run with **Product → Run** or `Command + R`.
7. Grant requested permissions when testing maps, location, photographs, or related features.

Some projects require network access. Apple Foundation Models and certain device features may not be available in every simulator or system configuration; fallback behavior is documented in the relevant project README.

## Portfolio value

Together, these projects demonstrate the ability to progress from foundational SwiftUI development to planning, implementing, testing, and documenting complete iOS applications. The repository provides practical examples of interface design, architecture, persistence, networking, framework integration, debugging, accessibility, and technical communication.

## Course information

* **Specialization:** Developing iOS Apps with Swift
* **Provider:** IBM
* **Platform:** Coursera
* **Taught by:** Ramanujam Srinivasan and SkillUp

## Disclaimer

This repository contains independent educational implementations created for coursework and portfolio demonstration. It is not an official IBM, Coursera, SkillUp, or Apple repository. IBM, Coursera, SkillUp, and Apple are trademarks of their respective owners.

