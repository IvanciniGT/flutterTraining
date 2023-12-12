
# What is flutter?

Flutter is an open-source framework for building cross-platform apps (for iOS, Android, Web, and Desktop) from a single codebase.
We mainly use Fluter to produce Mobile apps.
Flutter is created and maintained by Google.

The point with Flutter is that we can create a mobile app:
- Quickly
- With a single codebase
- With a native look and feel... kind of....
- With a good performance

## Mobile apps development

We have 2 operating systems for mobile devices: Android and iOS.

Android is developed by Google and iOS is developed by Apple.
Google decided to use Java as the main language for Android development.
But Apple decided to use Objective-C and later Swift as the main language for iOS development.
Each company developed its own SDK (Software Development Kit) to create apps for their operating systems.

This way... when ever we want to create an app for both operating systems we need to create 2 different apps.
- Android version of our app -> (Java ->) Kotlin  +  Android SDK < Android Studio
   Time ago... like... really long time ago... we used Java to create Android apps ... and we make use of Eclipse IDE to create them.
   Eclipse is not longer supported by Google... nowadays Google provides Android Studio.
   Android studio is based on IntelliJ IDEA (IDE for Java) and it is the official IDE for Android development.
   People from Google asked Jet Brains (the company behind IntelliJ IDEA) to create a version of IntelliJ IDEA for Android development.
   That version is offered by Google for free under the name: Android Studio.
   In addition, Google asked JetBRains to develop a new language for Android development... that language is Kotlin.
- iOS version of our app -> Swift + iOS SDK < XCode
   Apple provides XCode as the official IDE for iOS development.
   XCode is based on Eclipse and it is the official IDE for iOS development.
   Apple provides Swift as the main language for iOS development.

By using these languages, sdks and IDEs we can create NATIVE apps for both operating systems.
The good thing about this is:
- The performance of each app is gonna be really good... as they are native apps.
- We can use all the features of each operating system (SDK). Case we want to make use of the latest features of each operating system we can do it. Case we want to have a deeper integration with the operating system / hardware we will be able to do it (case we want to fully use the camera, the GPS, the accelerometer, etc... we will be able to do it).

The bad thing is that we will need to create 2 different apps. We will also need to maintain 2 different codebases.
This is not a problem for big companies... but for small companies or for independent developers this is a problem.
We have to learn 2 different languages, 2 different sdks and 2 different IDEs.
And we will need to create 2 different apps... and maintain 2 different codebases.

## Alternatives to native apps

There are a several number of alternatives to native apps: Ionic, React Native, Xamarin, Flutter, etc...
When using these frameworks we will be able to create a single app and use it for both operating systems.

That's great, because:
- We will be able to create a single app and use it for both operating systems.
- With just 1 codebase to develop and maintain.
- We will need to learn just 1 language, 1 sdk and 1 IDE.

The drawbacks are:
- That we will not be able to use all the features of each operating system.
- We will not be able to make a deep integration with the operating system / hardware.
- The performance of the app will not be as good as the performance of a native app.

That used to be true... but with flutter things have changed.

## Flutter

Flutter is a framework created by Google to create cross-platform apps.
We will have 1 single codebase and we will be able to use it for both operating systems.
We will create the app using Dart as the MAIN programming language.
As... we will be able to create specific functions/operations both in Java/Kotlin for Android and Swift for iOS.... case we need them.
We will be able to do most of the work using Dart.... and that code will be used for both operating systems. But for more specific things we will be able to use Java/Kotlin for AndroidSDK and Swift for iOS SDK.

In addition Flutter is really fast... it is really close to native apps in terms of performance.

### Flutter Widgets

Flutter is based on Widgets.
Widgets are the building blocks of Flutter apps.
Widgets are used to create the UI of the app.
Flutter / Google provides a wide set of widgets that we can use to create our apps.
We would have widgets for buttons, text, images, tabs, lists, etc...

Those widgets do not compile to native widgets... they are not native widgets.... I mean:
In the android sdk we have a widget for buttons, lists, tabs... and same we have in the iOS sdk.
Flutter provides is own widgets... and it provides its own tool for rendering those widgets: Skia.

One thing here is that when creating the app... we would net to make use of those widgets... and we have different implementations for each operating system: Material Design (look like the AndroidSDK widgets) and Cupertino (look like the iOS SDK widgets).
But we will only make use of 1 implementation... we will not be able to use both implementations at the same time.
That means that eventhough we will be able to create a single app for both operating systems... It will have a smell of Android or iOS... but not both at the same time. That's weird... but that's the way it is.

One nice thing we have with flutter: Hot Reload.
We can open an emulator and run our app (test*)... and we can make changes to the code and see the changes in the emulator without the need to restart the app. That allows an extremely fast development.
* To test the iOS version of our app we will need a Mac Computer.
  Android studio we will have an integration with the iOS emulator... which is part of XCode... and XCode only runs on Mac.
  Android studio does provide an emulator for Android... so we will be able to test the Android version of our app without the need of a physical device.
  Actually XCode libraries are also used to compile the iOS version of our app... so anyways (even if we have a physical iOS device) we will need a Mac computer to compile the iOS version of our app.

---
### Dart

Dart is a programming language created by Google....Google did not create Dart to create Flutter... Dart first appeared in 2011. Flutter appeared in 2017. Dart was created by Google as a replacement for JavaScript.... Actually they did not succeed... Dart is not used as a replacement for JavaScript... and actually nobody was using dart until Flutter appeared.

It is an extremely easy language to learn... it is really similar to Java and JavaScript.
---

# Setup an environment for this training

√ Android Studio already installed *** RIGHT NOW ***
√ Download Flutter SDK and decompress it somewhere in our computer
- Install Plugins for Android Studio (Flutter and Dart)

# Create our first project (dummy app... Hello World)

---


# Todo list app


