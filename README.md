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

## Screenshots

<p align="center">
  <img src="images/IMG_7253.PNG" width="250">
  <img src="images/IMG_7254.PNG" width="250">
  <img src="images/IMG_7255.PNG" width="250">
  <img src="images/IMG_7256.PNG" width="250">
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
   - User can navigate back to Home

4. History View
   - Loads BathingEvents from the database
   - Displays swim times in a list

---

## Persistence

The app uses Sembast as a local database.

- The database is opened once in main()
- The database instance is stored in Block
- Swim sessions are stored in the "bathing_events" store
- DateTimes are saved as UTC ISO 8601 strings

---

## Architecture

- Block
  Creates the models

- ViewModels
  Communication between views and models

- Views
  Handle UI and navigation

- Models
  Holds long-lived services (MovesenseDeviceManager, database)

---

## Notes

- To connect you must use a personal UUID/BlueTooth address to connect.
