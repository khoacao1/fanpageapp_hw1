import 'package:fanpageapp_kc/models/user.dart';
import 'package:fanpageapp_kc/screens/authenticate/authentication.dart';
import 'package:fanpageapp_kc/screens/home/home.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/admin.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ObjectUser?>(context);

    //return either Home or authentication
    if (user == null) {
      return Authenticate();
    } else {
      if (user.uid == 'zuSCGa3VF8Pa4basyHp5hWyG5sM2') {
        return Admin();
      } else {
        return Home();
      }
    }
  }
}
