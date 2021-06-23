# fanpageapp_hw1

This is my fanpage app for iOS and Android.

I've only tested this app on Android and iOS simulator. All functions required in the homework .pdf was performed on the demo video.


After flutter is installed properly, setting up the simulator, locate the fanpageapp_kc directory in terminal and execute these command line 'flutter pub get', 'flutter run'. This should install the app into your simulator.

This app contains the requirement of the homework:
1. Splash Screen is my image.
2. Firebase API was integrated into the application.
3. Contain Register page and Login page.
	- New registed user will have unique ID, First Name, Last Name, Register datetime and non-admin role by default store in database.
	- Social Media can login as normal user.
4. One account is ADMIN.
5. Admin have the ability to add new post. Messages store on Cloud Firestore. Each message has unique ID and posted datetime.
6. All User and Admin have ability to see all the messages in real time.
7. Log Out button available for all User and Admin after they log in.


Demo Video's link: https://youtu.be/K53whCtelrQ
In this videos, the performance of the app was tested on iOS and Android simulators.
