# Skin Cancer Detection with Machine Learning (NeuraDerm App)

## Introduction

### Problem: Skin Cancer
Skin cancer is the uncontrolled growth of abnormal skin cells, often caused by UV exposure. Early detection is crucial for effective treatment. The main types include:
- **Basal Cell Carcinoma (BCC)**
- **Squamous Cell Carcinoma (SCC)**
- **Melanoma**

### Solution
We employ machine learning to enhance skin cancer diagnosis accuracy and speed, providing better healthcare accessibility, especially in resource-limited settings.

## Machine Learning Methodology

### Modeling Strategy
We use a sequence of three deep learning models:
1. **Model-1:** Validates if the image is a skin image.
2. **Model-2:** Classifies dermascope images.
3. **Model-3:** Classifies clinical images.

#### Steps
1. **Upload Image:** User uploads a skin image.
2. **Validation:** Image is validated using Model-1.
3. **Classification:** If valid, classified by Model-2 or Model-3.
4. **Output:** Final predicted class includes:
   - Melanoma
   - Melanocytic Nevi
   - Basal Cell Carcinoma
   - Other benign and malignant lesions.

Invalid images are classified as "Unknown."

### Tools and Libraries
- **NumPy**
- **TensorFlow**
- **Pandas**
- **Matplotlib**
- **Pillow**
- **Colab**
- **Scikit-Learn**
- **Kaggle**

### Data Handling
- Explored the HAM10000 dataset using Python and Matplotlib.
- Addressed dataset imbalance via oversampling and data augmentation.

### Model Training
Trained models for 30 epochs with accuracies:
- **Model-1:** 99% training, 98% test.
- **Model-2:** 97% training, 93% test.
- **Model-3:** 99% training, 97% test.

### Deployment
Models were saved in TFlite format and an API was created using FastAPI, deployed on AWS EC2.

## Mobile Application

### Overview
The mobile app assists in skin cancer detection for patients and doctors by analyzing skin images for diagnostic insights.

### Features
- **AI Image Testing:** Upload images for analysis.
- **Clinic Information:** Access to specialized clinics.
- **Appointment Booking:** Simplified clinic booking.
- **QR Code Generation:** Unique QR codes for clinic interactions.

### Architecture
The app follows Clean Architecture principles with:
- **Feature Layer:** UI components.
- **Data Layer:** Data retrieval management.
- **Model Layer:** Data structures.

## Backend

### Development
Built with .NET using:
- **LINQ** for data querying.
- **SQL Server** for storage.
- **Entity Framework** for database interactions.
- **JwtBearer** for authentication.
- **Stripe** for payments.

### Design Patterns
Utilized:
- **N-Tier Architecture**
- **Repository Pattern**
- **Unit of Work Pattern**
- **Dependency Injection**

### Database Design
Includes tables for users, roles, clinics, appointments, and detection data.

### Project Structure
- **SkinCancer.Api:** Main application entry.
- **SkinCancer.Entities:** Data models.
- **SkinCancer.Repositories:** Data access.
- **SkinCancer.Services:** Service classes.

## Conclusion
This project leverages Convolutional Neural Networks for skin cancer detection and features a Flutter mobile app with a .NET backend. Our work emphasizes the importance of early detection and the potential of AI in medical diagnostics.

Thank you for your interest in our project! ✨

---

### Getting Started
To begin, clone the repository. Machine Learning notebooks and models can be found in the [MachineLearning](./MachineLearning) folder with instructions for running the models. You can also find the latest build of the app [here]().

### License
Licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.