// import 'dart:html';
import './pages/waiting/waiting_time_page.dart';
import 'package:flutter/foundation.dart';

// import './pages/chat/user_list_page.dart';
import './widgets/waiting/waiting_list.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './pages/chat/chat_room_list_page.dart';
import './pages/chat/auth_page.dart';
import './pages/chat/user_profile_edit_page.dart';
// import './pages/chat/user_list_page.dart';
// import './widgets/chat/user_profile_image_picker.dart';
import 'pages/chat/chat_room_page.dart';
import './pages/chat/user_profile_page.dart';
import './providers/auth.dart';
import './pages/waiting/join_waiting_page.dart';
import './widgets/waiting/waiting_list_drawer.dart';
import './pages/chat/guest_chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userId = '';
  }

  String _getUserId() {
    var user = FirebaseAuth.instance.currentUser;
    // setState(() {
    //   _userId = user.uid;
    // });
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        // StreamProvider<User>.value(value: FirebaseAuth.instance.authStateChanges()),
      ],
      child: MaterialApp(
        title: 'Chat_Wainting_Trinity',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.green,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
        // StreamBuilder(
        //     stream: Auth.instance.authState,
        //     // stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (ctx, userSnapshot) {
        //       if (userSnapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       if (userSnapshot.hasData) {
        //         // print(user.uid);
        //         return ChatRoomListPage();
        //       }
        //       return AuthPage();
        //     }),
        routes: {
          '/home': (ctx) => MyHomePage(),
          UserProfileEditPage.routeName: (ctx) =>
              UserProfileEditPage(Auth.instance.userId),
          // UserListPage.routeName: (ctx) => UserListPage(),
          ChatRoomListPage.routeName: (ctx) => ChatRoomListPage(),
          ChatRoomPage.routeName: (ctx) => ChatRoomPage(),
          UserProfilePage.routeName: (ctx) => UserProfilePage(),
          GuestChatPage.routeName: (ctx) => GuestChatPage(),
          // UserProfileImagePicker.routeName:(ctx)=>UserProfileImagePicker(),
          // WaitingListPage.routeName: (ctx) => WaitingListPage()
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum SelectPage { home, waiting, chat }

class _MyHomePageState extends State<MyHomePage> {
  var _selectedPage;
  String _selectList = 'active';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedPage = SelectPage.home;
  }

  void _selectListOption(String selected) {
    setState(() {
      _selectList = selected;
    });
  }

Future<void> _showExitDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Do you want sign out?'),
          actions: [
            FlatButton(
                child: Text('Yes'),
                // onPressed: () => Navigator.pop(c, true),
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseAuth.instance.signOut();
                  // Navigator.popAndPushNamed(context, '/home');
                }),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }
  Widget _mainPage() {
    print('main page');
    if (_selectedPage == SelectPage.waiting) {
      return StreamBuilder(
          stream: Auth.instance.authState,
          // stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (userSnapshot.hasData) {
              return JoinWaitingPage();
            }
            return AuthPage();
          });
    }
    if (_selectedPage == SelectPage.chat) {
      return StreamBuilder(
          stream: Auth.instance.authState,
          // stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (userSnapshot.hasData) {
              // print(user.uid);
             return FirebaseAuth.instance.currentUser.uid == 'twn4iAv7bmbYVvFUdQ9Ocyj25Vr1'?  GuestChatPage() : ChatRoomListPage();
            // return  kIsWeb ? GuestChatPage() : ChatRoomListPage();
            }
            return AuthPage();
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: kIsWeb ? Text('Join Waiting') : Text('Current Waiting List'),
        actions: [
          ( kIsWeb == true || (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser.uid == 'twn4iAv7bmbYVvFUdQ9Ocyj25Vr1'))
              ? IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => _showExitDialog()):IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () {}) ]
      ),
      drawer: kIsWeb ? null : WaitingListDrawer(_selectListOption),
      body: Container(
          child: kIsWeb ? WaitingTimePage() : WaitingList(_selectList)),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              setState(() {
                _selectedPage = SelectPage.waiting;
              });
            },
            tooltip: 'Join Waiting List',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                setState(() {
                  _selectedPage = SelectPage.chat;
                });
              },
              tooltip: 'Chat',
              child: Icon(Icons.chat)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainPage();
  }
}
