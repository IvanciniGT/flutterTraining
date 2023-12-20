
Right now we have fully functional app. It consists of 2 screens:
- A list of todos
- Settings screen: A form to edit the user's name and the preferred theme (light / dark).

And todos are persisted in the device's storage thru the "Hive" library.
Also Preferences are persisted in the device's storage thru the "Shared Preferences" library.

We want to persist the todos in a REST Backend also.
That would give us the ability to synchronize our todos with other devices.
That does not mean that we won't persist them in the device's storage anymore.
In case we don't have internet connection we will still be able to create, edit and delete todos. And once we have internet connection again we will synchronize our todos with the backend.

We get the best thing of both worlds:
- We can use our app offline. (local storage)
- We can synchronize our todos with other devices. (backend)

In order to make an example of this, we need a backend rest api.
We will create that with node and json-server.

Once we have that, we will need to implement some changes in our app.
We will make use of this library called "http" to make requests to that backend:
- STEP 1: add the http dependency to pubspec.yaml
- STEP 2: create a function to synchronize our todos with the backend.
- STEP 3: call that function when the app starts
  - also we could call that function when the user presses a button... <<<<
  - each 5 minutes...
  - before the user closes the app...

This function needs to:
- Get all the todos from the backend
- Get all the todos from the device's storage

And then:
- Compare them
For each todo in the remote:
- If it's not in the local: add it to the local
- If it's in the local: update it in the local or update it in the remote
   depending on which one is newer. (We won't be able to do this.. as we don't store the last date of modification of the todos).
   In our case we are just going to keep the local version.
    This copy would need to be updated in the backend.

For each todo in the local:
- If it's not in the remote: add it to the remote
- If it's in the remote: do nothing (it was process in the previous loop)

In addition to the update issue, we have another problem: when deleting a todo, we need to delete it in the backend also. We won't do that.