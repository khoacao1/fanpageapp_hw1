import 'package:fanpageapp_kc/screens/home/article_list.dart';
import 'package:fanpageapp_kc/services/auth.dart';
import 'package:fanpageapp_kc/shared/constants.dart';
import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  // Create instant object _auth
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFa8dadc),
      appBar: AppBar(
        title: Text('Welcome Admin!'),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2a9d8f),
        onPressed: () {
          _addNewPost(context);
        },
        child: Icon(Icons.add_comment),
      ),
      body: ArticleList(),
    );
  }

  void _addNewPost(context) async {
    String post = '';

    return showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: Text(
              'New Post',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF2a9d8f),
              ),
            ),
            content: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    post = value;
                  },
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Input Content'),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  if (post != '') {
                    dynamic result =
                        await _auth.post(post, DateTime.now().toString());
                    Navigator.of(context, rootNavigator: true).pop();
                  } else {
                    _errorPost(context);
                  }
                },
                child: Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2a9d8f),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFe76f51),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

void _errorPost(context) {
  showDialog(
    context: context,
    builder: (BuildContext bc) {
      return AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ALERT',
              style: TextStyle(
                  color: Color(0xFFe76f51),
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ],
        ),
        content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Content Required',
                style: TextStyle(
                    color: Color(0xFFe76f51),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                padding: EdgeInsets.all(8),
                minWidth: 180,
                color: Color(0xFF2a9d8f),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              )
            ]),
      );
    },
  );
}
