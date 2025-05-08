Flutter Console Shop App
1. Project Structure

shop_app/
     android/
        assets/
            console.png 
            controller.png
            gamepad.png
    ios/
    lib/
        main.dart
    pubspec.yaml
    README.pdf


2. How to Configure the App
To configure the Flutter Console Shop App, follow these steps:

-Open the project in Android Studio.
-Ensure that the Flutter and Dart SDKs are installed.
-If not already present, create a folder named assets in the root of the project.
-Add the following image files to the assets/ folder:

    console.png
    controller.png
    gamepad.png

-Open the pubspec.yaml file and add the following under the flutter: section (ensure proper indentation):

flutter:
assets:
- assets/console.png
- assets/controller.png
- assets/gamepad.png
-Save the file and run:


3. How to Run the App
 To run your Flutter app:

-On Android Emulator
-Open Android Studio.
-Go to Tools → Device Manager.
-Click "Create Device" if no emulator exists, and configure it
-Once the emulator is created, click "Launch" (play icon) to start it.
-Open the file lib/main.dart.
-Click the green Run button or press Shift + F10.


4. Screenshots
    Below are screenshots of the application running on the Android Emulator.
     ![Screenshot (13).png](Images/Screenshot%20%2813%29.png)
     ![Screenshot (14).png](Images/Screenshot%20%2814%29.png)

these are the screenshots of the application demonstrating Home Page , items with there name and images , and cart sub total at the top.