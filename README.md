# MVVM Architecture with Repository Pattern in iOS

This repository demonstrates the implementation of the MVVM (Model-View-ViewModel) architecture along with the Repository Pattern in an iOS application using SwiftUI.

## Overview

### MVVM (Model-View-ViewModel) Architecture

**MVVM** is a software architectural pattern that separates the user interface (UI) from the business logic. It divides an application into three main components:

- **Model**: Represents the data and business logic of the application. It is responsible for retrieving and storing data, typically from a database or a web service.
- **View**: The UI layer that displays data to the user. It is a passive component that relies on the ViewModel to provide the data it needs to display.
- **ViewModel**: Acts as a bridge between the Model and the View. It retrieves data from the Model, processes it if necessary, and provides it to the View. It also handles user input, transforming it into actions that the Model will understand.

**MVVM Diagram:**
![image](https://github.com/Zulqurnain24/PhotoGallery/assets/6280238/ee5dbb2d-1a06-408b-9327-c5322251015c)



### Repository Pattern

The **Repository Pattern** is used to abstract the data layer, providing a clean API for data access to the rest of the application. It decouples the business logic and the data access, making the code easier to manage and test.

**Components of Repository Pattern:**

- **Repository**: A class that handles data operations. It mediates between the domain and the data mapping layers using a collection-like interface for accessing domain objects.
- **Data Sources**: Different sources of data, such as local databases, network services, or caches. The Repository interacts with these sources to fetch and store data.

**Repository Pattern Diagram:**

![image](https://github.com/Zulqurnain24/PhotoGallery/assets/6280238/8d5c5813-0af7-4897-9918-d28d73232ee4)



### MVVM with Repository Pattern Diagram

Combining the MVVM architecture with the Repository Pattern, the structure looks like this:

![image](https://github.com/Zulqurnain24/PhotoGallery/assets/6280238/666c523a-7ca7-4e67-9b24-1bcf712ea912)



