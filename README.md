<!-- center title and gif  -->
<h1 align="center">SiTech Books 📚<p>

<p align="center">
  <img src="docs/assets/readme.gif" alt="readme"/>
</p>

### A flutter task made for [SiTech](https://www.sitech.me/)

## Outlines

---

- #### Packages

  - [cached_network_image](https://pub.dev/packages/cached_network_image)
    - Used to cache images from the internet and save them for offline use.
  - [connectivity_plus](https://pub.dev/packages/connectivity_plus)
    - Used to check the internet status.
  - [dio](https://pub.dev/packages/dio)
    - App's http client.
  - [flutter_bloc](https://pub.dev/packages/flutter_bloc)
    - Used for state management.
  - [get_it](https://pub.dev/packages/get_it)
    - Used for dependency injection.
  - [lottie](https://pub.dev/packages/lottie)
    - Used to display animations and stories.
  - [once](https://pub.dev/packages/once)
    - Used to run functions periodically.
  - [shared_preferences](https://pub.dev/packages/shared_preferences)
    - Used to store data locally.

- #### App Structure

  - `/assets`
    - **Contains all the assets used in the app.**
  - `/docs`
    - **Contains all the documentation assets for the app.**
  - `lib/app`
    - `/layout`
      - **contains all the layout screens for the app.**
      - `/providers`
        - **contains the providers used in parent layout.**
    - `/shared`
      - **Contains all shared components in the app.**
      - `/models`
        - **Contains the models used in the app.**
      - `/widgets`
        - **Contains the UI widgets and components used in the app.**
      - `constants.dart`
        - **Contains all the constants used in the app.**
    - `/utils`
      - **Contains all the services and utils used in the app.**

- #### App Features
  
    - **Offline Support**
      - The app supports offline use, it caches all the data and images used in the app.
      - It uses the `shared_preferences` package to store the data locally. and checks the internet status using `connectivity_plus` package. and returns the cached data if the internet is not available. 
    - **Theme**
      - The app supports material 3 design and has a dark and light theme.
    - **Animations**
      - The app uses implict animations to make the user experience better. And also use lottie animations to display stories.
---
#### disclaimer
  The app full development time was aprox 3-4 hours and had to find ways to simplify the app and not to over engineer it. taking note that the app is not a production app and is just a task for SiTech. the main focus was to show the main functionality and the design of the app. rather than the code quality and the architecture of the app. while taking into consideration not to under engineer the app and make it lack performance and not to be able to scale. 