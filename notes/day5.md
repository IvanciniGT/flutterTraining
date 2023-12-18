
I did tell you that we were going to create today a new app from scratch ... like a more complex project.
Today is Monday.
We only have today, tomorrow and Wednesday to finish this project.
On Wednesday we will have a test... and actually just 2 hours of class

---

We will continue with the project we were working on last week.
We will just improve it a bunch!

---

Right now we have a simple todo app. It consists of 2 screens:
- A list of todos
- A form to create or edit a todo

It's actually a very simple app. But it's a good start.... I mean... we did a really nice job defining the architecture of the app.

Improvements:
- A splash screen.
- a navigation tab bar: √
  - Home screen: List of todos √
  - Settings screen: A form to edit the user's name and the preferred theme (light / dark).  √
    - ---> PERSISTENCE -> Library "Shared Preferences"
- Persist the todos in the device's storage. ---> PERSISTENCE
    Convert each Todo into a JSON string and save it in a local DB: Library "Hive"
- Synchronize our database with a REST Backend ---> Library "http"

We will need to learn ho to deal with JSON from flutter(Dart).
---

SettingsScreen:

------------
Name:
___________

Dark Theme:  [ |X]


------------

* NOTE: We are not gonna have a save button. We will save the changes as soon as the user makes them.

Are we using that information in this Widget actually? NO
name : _MainScreenState
dark_theme_enabled : TodoListApp

Here we have a problem!

How are we going to pass information from the SettingsScreen to the MainScreen and to the TodoListApp?

We will use a technique called "State Management"Here we can make use the "Shared Preferences" library.

Each time the user changes those values we will save them in the device's storage.
Each time we access the MainScreenState or the  TodoListApp we will load that information from the device's storage.

That's what we can do with the "Shared Preferences" library.
WE DON'T LIKE THIS SOLUTION AT ALL!
That solution makes our code very messy and hard to maintain... in addition we would be just reading and reading and reading more from the device's storage.

The device storage is just for PERSITENCE. We should not use it for anything else.

We could find a different solution for this problem.
To make use of a State management library, such as the BLOC library, we are already using.
We just need to define a new "State" : {userName, darkThemeEnabled}
Each time we change that from the settings screen, we will update that global status using bloc.
Then, at that time, we will store that information in the device's storage (Shared Preferences).
Then each time we start the app, we will load that information from the device's storage and update the global state.
And each time the global state changes, we will notify the MainScreen and the TodoListApp.

This is an improved solution.


    TODO LIST APP        <------          Global State (managed through BLOC)
        MAIN SCREEN      <------                userName
        SETTINGS SCREEN                         darkThemeEnabled
            v                                       ^
            event: change userName          --->   BLOC  ---> We will store that information in the device's storage
            event: change darkThemeToogle   --->                (Shared Preferences)
                                                   ^           
                                              preferencesLoaded
                                                    ^               
    When we start the app, we will load the global state from the device's storage (Shared Preferences)
    And will send an event to the BLOC to update the global state.
    (main.dart)


You cannot implement this already... as you don't know how to deal with the device's storage yet (Shared Preferences).
**But... you already know how to implement the BLOC pattern and the global state management.**