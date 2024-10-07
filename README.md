# Skin Cancer Detection with Machine Learning (NeuraDerm App)

## Overview

Skin cancer, characterized by the uncontrolled growth of abnormal skin cells due to UV exposure, poses a significant health risk. Early detection is essential for effective treatment. The primary types of skin cancer include:

- **Basal Cell Carcinoma (BCC)**
- **Squamous Cell Carcinoma (SCC)**
- **Melanoma**

The **NeuraDerm App** leverages machine learning to improve the accuracy and speed of skin cancer diagnosis, making healthcare more accessible, particularly in resource-limited environments.

## Machine Learning Approach

### Modeling Strategy

Our solution involves a robust sequence of three deep learning models:

1. **Model 1:** Validates if the uploaded image is a skin image.
2. **Model 2:** Classifies dermatoscopic images.
3. **Model 3:** Classifies clinical images.

### Workflow

The detection process follows these steps:

1. **Image Upload:** Users upload a skin image.
2. **Validation:** The image is validated using **Model 1**.
3. **Classification:** If validated, the image is classified by either **Model 2** or **Model 3**.
4. **Output:** The system predicts the class, which may include:
   - Melanoma
   - Melanocytic Nevi
   - Basal Cell Carcinoma
   - Other benign or malignant lesions

Images that do not meet validation criteria are classified as "Unknown."

### Tools and Technologies

Our project utilizes the following libraries and tools:

- **NumPy**
- **TensorFlow**
- **Pandas**
- **Matplotlib**
- **Pillow**
- **Google Colab**
- **Scikit-Learn**
- **Kaggle**

### Data Management

- Explored the **HAM10000** dataset with Python and Matplotlib.
- Addressed data imbalance through techniques such as oversampling and data augmentation.

### Model Training

Each model was trained for 30 epochs, achieving the following accuracies:

- **Model 1:** 99% training accuracy, 98% testing accuracy.
- **Model 2:** 97% training accuracy, 93% testing accuracy.
- **Model 3:** 99% training accuracy, 97% testing accuracy.

### Deployment

Models were saved in TensorFlow Lite format, and an API was created using **FastAPI**, deployed on **AWS EC2** for seamless integration.

## Mobile Application

### Purpose

The NeuraDerm mobile application empowers patients and healthcare providers by analyzing skin images to deliver valuable diagnostic insights.

### Key Features

- **AI Image Testing:** Users can upload images for instant analysis.
- **Clinic Information:** Access to specialized dermatology clinics.
- **Appointment Booking:** Streamlined process for scheduling appointments.
- **QR Code Generation:** Unique QR codes for easy clinic interactions.

### Architecture

The app adheres to **Clean Architecture** principles, structured into three main layers:

- **Feature Layer:** Responsible for user interface components.
- **Data Layer:** Manages data retrieval and storage.
- **Model Layer:** Defines data structures used throughout the app.

## Backend Development

### Framework

The backend is built with **.NET** and includes:

- **LINQ** for data querying
- **SQL Server** for database storage
- **Entity Framework** for data access
- **JwtBearer** for secure authentication
- **Stripe** for payment processing

### Design Patterns

We utilized various design patterns to ensure a robust architecture:

- **N-Tier Architecture**
- **Repository Pattern**
- **Unit of Work Pattern**
- **Dependency Injection**

### Database Structure

The database encompasses tables for:

- Users
- Roles
- Clinics
- Appointments
- Detection data

### Project Organization

The project is organized into several key components:

- **SkinCancer.Api:** Main application entry point
- **SkinCancer.Entities:** Data model definitions
- **SkinCancer.Repositories:** Data access layers
- **SkinCancer.Services:** Service classes for business logic

## Conclusion

The **NeuraDerm App** combines Convolutional Neural Networks with a user-friendly mobile interface and a robust .NET backend, emphasizing the critical role of early skin cancer detection and the transformative potential of AI in medical diagnostics.

Thank you for your interest in the NeuraDerm project! ✨

---

## Getting Started

To get started, clone the repository. You can find the machine learning notebooks and models in the [MachineLearning](./MachineLearning) directory, along with instructions for running the models. The latest build of the app is available [here](). Documentation and other assets are on the associated [GoogleDrive](https://drive.google.com/drive/folders/1FXMeqFnf-5xM6mwTU0ZJxCGCH6LpI54o?usp=sharing).

## License

This project is licensed under the MIT License. For more details, please refer to the [LICENSE.md](LICENSE.md) file.