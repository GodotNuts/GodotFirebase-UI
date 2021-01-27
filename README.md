# GodotFirebase-UI

A UI library for Godot Engine built on top of [GodotFirebase addon]() that provides drop-in Control nodes with self-contained Authentication, Firestore and Database functions.  
Instance a component, connect its signals and you are ready!

## FirebaseUI
This library is inspired to [FirebaseUI](https://firebase.google.com/docs/auth/web/firebaseui), which is a JavaScript library specifically build to help implement ready-to-use components on top of FirebaseSDK.  
Alongside with the development of our addon [GodotFirebase], we decided to provide our own collection of Godot Engine components in the form of ready-to-use Control nodes, already configured to communicate with our library to facilitate Authentication, Firestore and Database management, and so on.

## Components
*Components* are simple Control nodes with custom scripts and styles in a way that they are both configurable with GDScript and within the Inspector.  
Components can be grouped in two main categories:  
- Base Components, such as base buttons and fields: they can be further customized in aspect and functions
- Top Components, such as ready to use buttons (Google button, Anonymous login button), fields (email field, password field),  containers (Auth, Firestore, Database).

### List of available components
|Component|Usage|
|-|-|
|`CustomBaseButton (/buttons/base_button/base_button.tscn)`|A customizable basic button with icon and colored text.|
|`EmailButton (/buttons/email_button/email_button.tscn)`|A button for email sign-up / sign-in processes.|
|`EmailField (/field_containers/email_field/email_field.tscn)`|A field container for emails, with email-check logic.|
|`SignContainer (/auth/sign_container/sign_container.tscn)`|A container for Firebase Authentication.|

![demo_1](./images/demo_1.gif)