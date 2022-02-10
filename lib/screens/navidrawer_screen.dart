import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/model/user_model.dart';
import 'package:homeapp/screens/account_manager_screen.dart';

import 'login_screen.dart';
class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("${loggedInUser.firstName} ${loggedInUser.secondName}"),
            accountEmail: Text("${loggedInUser.email}"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text("A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          new ListTile(
            leading: Icon(Icons.home), title: Text("Home"),
            onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountManager()));
            },
          ),
          new ListTile(
            leading: Icon(Icons.account_circle), title: Text("Account Manager"),
             onTap:(){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountManager()));
             },
          ),

          new ListTile(
            leading: Icon(Icons.contacts), title: Text("Contact Us"),
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountManager()));
            },
          ),
          new ListTile(
            leading: Icon(Icons.logout), title: Text("Log Out"),
            onTap:(){
              logout(context);
            },

          ),

        ],
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
