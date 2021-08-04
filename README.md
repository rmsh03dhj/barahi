# Photo Viewer App

This Photo Viewer is developed using Flutter Framework. I have followed clean code architecture, used [flutter bloc](https://pub.dev/packages/flutter_bloc) for state management and [dartz](https://pub.dev/packages/dartz) which makes error handling easier.

This app basically has 3 screens namely splash screen, login or sign up screen and dashboard screen to display images.

To authenticate user, I have used [firebase authenticaton](https://pub.dev/packages/firebase_auth). Once the user is authenticated, whenever he opens the app, he will be directly taken to dashboard screen after splash srcreen.
To store, images, I have used [firebase storage](https://pub.dev/packages/firebase_storage) and to operate with data related to image, like uploaded at, file name, favourite, etc, I have use [cloud firestore](https://pub.dev/packages/cloud_firestore).

In the app user can

- sign up, sign in or logout. (email and password only)
- upload image both from camera and photo gallery.
- delete image.
- rename image file name at any time.
- add/remove image to/from my favourite.
- search image by file name.
- share image.
- rotate or zoom image
- sort images by file name, favourite and uploaded date.
- responsive to both landscape and potrait modes.

**_Note: share image to other users and login with username is incomplete._**

For project demo, I have attached a video below.

<p align="center">
<img src="demo.gif" width="220" height="450"/>
</p>
