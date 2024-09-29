---

# SLTC Foodie - Admin Panel

SLTC Foodie Admin Panel is a Flutter-based mobile application designed for restaurant administrators to manage food items and orders. The app leverages Firebase for data management, authentication, and cloud storage. Admins can log in, add new food items with details such as images, prices, offers, and descriptions, and manage customer orders by viewing order details like the customer's name, ordered items, and prices.

<img src="https://github.com/sahan026/images/blob/main/SLTC_FOODIE%20ADMIN%20LOGO.png" alt="App Icon" width="150" height="150">

## Features

- **Admin Authentication**: Admins log in through Firebase Authentication to access the app.
- **Home Page**: Displays a list of orders placed by customers. Admins can click on any order to view its details.
- **Order Details**: Each order contains information about the customer, the items ordered, quantity, price, and time of order.
- **Manage Food Items**: Admins can add, edit, or remove food items, including uploading food images and setting prices and offers.
- **Drawer Menu**: Home, Settings, and Logout options. The settings page allows admins to toggle between dark and light mode.
- **Theming**: Dark mode and light mode toggling in the settings.

## App Workflow

1. **Login/Registration**:
    - The app opens to the login page where users can either log in or register.
    - Upon successful login or registration, users are navigated to the home page.

     <img src="https://github.com/sahan026/images/blob/main/SLTC_login_page.jpg" alt="Login Page" width="250" height="500">

2. **Home Page**:
    - The home page displays a list of customer orders. Each order card shows basic details such as the order time and total price.
    - Clicking on an order card navigates the admin to a detailed order view.
    - A floating action button at the bottom right allows the admin to add new food items.

    <img src="https://github.com/sahan026/images/blob/main/adminhomepage.jpg" alt="Home Page" width="250" height="500">

3. **Add Food**:
    - Admins can add new food items by clicking the floating action button. They are prompted to fill in food details such as name, price, offer, and upload a food image.
    - After filling in the details, clicking "Add Food Item" saves the food item to Firestore.

    <img src="https://github.com/sahan026/images/blob/main/addfooditems.jpg" alt="Food Details" width="250" height="500">

4. **Drawer Menu**:
    - The drawer contains options for Home, Settings, insert foods, and Logout.
    - At the bottom of the drawer, the "Logout" button logs users out of the app.

5. **Settings Page**:
    - The settings page contains a toggle for switching between dark mode and light mode.

    <img src="https://github.com/sahan026/images/blob/main/SLTC_setting_page.jpg" alt="Settings Page" width="250" height="500">


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
    - incertfood.dart
    - FoodDetails.dart
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
