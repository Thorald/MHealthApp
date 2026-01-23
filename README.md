# Mobile-Health-Application---Heart-Rate-Measurements-During-Cold-Water-Immersion

A Flutter app for tracking swimming sessions using a Movesense device.
Swim sessions are stored locally and can be viewed later.

---

## Overview

The app consists of the following main views:
- Home view
- During swim view
- History view
- Connect view

---

## Screenshots


<p align="center">
  <img src="images/IMG_7253.PNG" width="200">
  <img src="images/IMG_7256.PNG" width="200">
  <img src="images/IMG_7254.PNG" width="200">
  <img src="images/IMG_7255.PNG" width="200">
</p>

---

## App Flow

1. Connect View
   - User presses Bluetooth_Connect
   - Connection is established using UUID and MDS_flutter_plus plugin

2. Home View
   - User presses START
   - Transitions to "During Swim View"
   - A new BathingEvent is instantiated with the current time

3. During Swim View
   - Live heart rate is shown using a stream
   - User presses STOP
   - The BathingEvent is saved to the local database (Sembast)
   - Json file is also dumped to /var/mobile/Containers/Data/Application/"your_specific_UUID"/Documents/
   - User can navigate back to Home

4. History View
   - Loads BathingEvents from the database
   - Displays swims in a listview

---

## Persistence

The app uses Sembast as a local NoSQL database.

- The database instance is managed by the `Block` class.
- On iOS, the database file is stored in the app’s sandboxed
  `Documents` directory, resolved at runtime using `path_provider`.
- Internally, this corresponds to a path of the form:
  `/var/mobile/Containers/Data/Application/<UUID>/Documents/`

---

## Architecture

- `Block` is responsible for instantiating and holding long-lived services.
- ViewModels mediate communication between the Views and the Models.
- Views handle UI rendering and user navigation.
- Models encapsulate data structures and long-lived services.

---

## How to setup App.

- To connect you must use a personal UUID/BlueTooth address. This needs to be changed in the [Movesense device manager](flutter_application/lib/model/movesense_device_manager.dart)
- The App has not been testet on Android but in theory a BlueTooth address should work for that system. Use UUID for Iphone.
- To add weather data from: https://home.openweathermap.org one needs to go to this website and generate a free API key. This can then be inserted in [main](flutter_application/lib/main.dart).
- Also to get all location/bluetooth data, these need to be permitted, which is automatically initiated on the apps first startup.

---

## Further information

for further information please see our [overleaf_project](overleaf_project/mHealth_projekt.pdf)