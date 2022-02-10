import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/screens/reset_screen.dart';
import 'login_screen.dart';
import 'package:homeapp/model/user_model.dart';

class AccountManager extends StatefulWidget {
  const AccountManager({Key? key}) : super(key: key);

  @override
  _AccountManager createState() => _AccountManager();
}

class _AccountManager extends State<AccountManager> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Account management"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Welcome Home",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Name: ${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("Email: ${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              ActionChip(

                  label: Text("Logout", style: TextStyle(fontSize: 20, fontFamily: 'Pushster', color: Colors.redAccent),),
                  onPressed: () {
                    logout(context);
                  }),
              ActionChip(
                  label: Text("Change password", style: TextStyle(fontSize: 20, fontFamily: 'Pushster', color: Colors.redAccent),),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ResetScreen()));
                  }),
              ActionChip(
                  label: Text("Change Avatar", style: TextStyle(fontSize: 20, fontFamily: 'Pushster', color: Colors.redAccent),),
                  onPressed: () {

                  }),
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}