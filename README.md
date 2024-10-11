
# Flutter Currency Converter App

This is a simple currency converter application built using Flutter. It allows users to convert amounts between different currencies using real-time exchange rates from the [ExchangeRate-API](https://www.exchangerate-api.com/).

## Features

- **Real-time Exchange Rates**: Fetches live conversion rates from the API.
- **Multiple Currencies**: Supports selection of both base and target currencies.
- **Dark Mode**: The app applies a dark theme to enhance user experience.
- **Error Handling**: Provides meaningful error messages if API calls fail or invalid inputs are given.
- **Simple User Interface**: Clean and easy-to-use interface with clear conversion results.

## Getting Started

Follow these steps to run the currency converter app on your local machine.

### Prerequisites

Before starting, ensure you have the following:

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK**: Included with Flutter, but ensure it is set up properly.
- **API Key**: Sign up and obtain a free API key from [ExchangeRate-API](https://www.exchangerate-api.com/).


## Demo

https://github.com/user-attachments/assets/9aa9f1a7-c897-4f5c-a417-c5c33b08d4af





### Installation Steps

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Siddiqui145/Currency_Converter_App.git
   cd Currency_Converter_App
   ```

2. **Install dependencies**:

   Run the following command to install the necessary packages:

   ```bash
   flutter pub get
   ```

3. **Configure API Key**:

   Open the file `Currency_ConvertWork.dart` and replace the placeholder API key with your own from ExchangeRate-API.

   ```dart
   String apiKey = 'your-api-key-here';  // Add your API key here
   ```

4. **Run the App**:

   Run the following command to start the app on your preferred device (emulator or physical device):

   ```bash
   flutter run
   ```

## Screenshots


![Screenshot_20241012_002612](https://github.com/user-attachments/assets/ae90ae28-8f9b-403e-8592-e1f8d2bdafee)

![Screenshot_20241012_002628](https://github.com/user-attachments/assets/ca7dd27f-acae-4698-a547-fc8670ec37bd)

![Screenshot_20241012_002618](https://github.com/user-attachments/assets/7f99f492-7df6-45e5-b353-adff4d8c8855)

## App Structure

- **main.dart**: This is the main entry point of the app.
- **Currency_ConvertWork.dart**: This file contains the logic for fetching exchange rates and
the app's UI components.



## API

This app uses the [ExchangeRate-API](https://www.exchangerate-api.com/) to fetch real-time conversion rates. Make sure to replace `'your-api-key-here'` with your actual API key in the code to use the service.
