---

# SLTC Foodie

SLTC Foodie is a Flutter-based mobile application that manages food items and orders for a restaurant using Firebase for data management, authentication, and cloud storage. The app allows users to log in or register, manage food items, toggle between dark and light modes, and place orders.

<img src="https://github.com/sahan026/images/blob/main/SLTC_app_iocn.png" alt="App Icon" width="150" height="150">

## Features

- **Authentication**: Login or Register using Firebase Authentication.
- **Home Page**: Displays food details (name, price, offer, and image) in a card view. Each food card navigates to a detailed food page where users can add/remove items and see the total price.
- **Add Food**: Users can add new food items with a name, price, offer, and image via a floating action button.
- **Drawer Menu**: Home, Settings, and Logout options. The settings page allows users to switch between dark mode and light mode.
- **Payments**: Users can proceed to the payment page and enter Visa card details to complete the purchase.
- **Theming**: Dark mode and light mode toggling in the settings.

## App Workflow

1. **Login/Registration**:
    - The app opens to the login page where users can either log in or register.
    - Upon successful login or registration, users are navigated to the home page.

     <img src="https://github.com/sahan026/images/blob/main/SLTC_login_page.jpg" alt="Login Page" width="250" height="500">

2. **Home Page**:
    - The home page displays a list of food items in a card format, showing the food name, price, offer, and a small food image.
    - Each card can be clicked to navigate to the detailed food page.
    - A floating action button in the bottom right allows users to add a new food item.

    <img src="https://github.com/sahan026/images/blob/main/SLTC_home_page.jpg" alt="Home Page" width="250" height="500">

3. **Food Details**:
    - Clicking on a food item card navigates to the detailed food page, which shows all details about the food item (name, price, offer, and image).
    - Users can add or remove the item using the plus and minus buttons, and the total price is updated accordingly.
    - Clicking the "Pay Now" button navigates to the payment page.

    <img src="https://github.com/sahan026/images/blob/main/SLTC_food_details_page.jpg" alt="Food Details" width="250" height="500">

4. **Add Food**:
    - When users click the floating action button, they are prompted to add a new food item.
    - Fields include food name, price, offer, and an option to upload a food image using the image picker.
    - After filling in the details, users click "Add Food Item" to save the food item to the Firestore database.

    <img src="https://github.com/sahan026/images/blob/main/SLTC_add%20food_item_page.jpg" alt="Add Food" width="250" height="500">

5. **Drawer Menu**:
    - The drawer contains options for Home, Settings, and Logout.
    - At the bottom of the drawer, the "Logout" button logs users out of the app.

6. **Settings Page**:
    - The settings page contains a toggle for switching between dark mode and light mode.

    <img src="https://github.com/sahan026/images/blob/main/SLTC_setting_page.jpg" alt="Settings Page" width="250" height="500">

7. **Payment**:
    - Users can proceed to the payment page after adding food items to their cart.
    - On the payment page, users enter Visa card details and click "Pay Now" to complete the transaction.

    <img src="https://github.com/sahan026/images/blob/main/SLTC_payment_page.jpg" alt="Payment Page" width="250" height="500">

## Folder Structure

```
/lib
  /components
    - my_drawer.dart
    - my_drawer_title.dart
    - my_button.dart
    - my_textfield.dart
  /pages
    - login_page.dart
    - registar_page.dart
    - home_page.dart
    - setting_page.dart
    - PaymentPage.dart
    - employee.dart
    - EmployeeDetails.dart
  /service
    /auth
      - auth_gate.dart
      - auth_service.dart
      - login_or_registar.dart
    /database
      - database.dart
  /theme
    - dark_mode.dart
    - light_mode.dart
    - theme_provider.dart

- main.dart
- session_manager.dart
- timeout_manager.dart
```

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/sltc-foodie.git
   ```

2. Install the required dependencies:
   ```bash
   flutter pub get
   ```

3. Setup Firebase:
   - Create a Firebase project named `scurd`.
   - Enable Firestore, Firebase Storage, and Firebase Authentication.
   - Download the `google-services.json` file and place it in the `/android/app` directory.

4. Run the app:
   ```bash
   flutter run
   ```

## Contributions
Feel free to contribute by making a pull request or opening issues.

---
