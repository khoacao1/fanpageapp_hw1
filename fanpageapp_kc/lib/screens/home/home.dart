import 'package:fanpageapp_kc/screens/home/article_list.dart';
import 'package:fanpageapp_kc/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  // Create instant object _auth
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5e1eb),
      appBar: AppBar(
        title: Text('Welcome!'),
        backgroundColor: Color(0xFF2a9d8f),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            textColor: Color(0xFFFFFFFF),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text("Log Out"),
            icon: Icon(Icons.person_outlined),
          ),
        ],
      ),
      body: ArticleList(),
    );
  }
}
