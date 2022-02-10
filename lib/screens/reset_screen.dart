import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final TextEditingController emailController = new TextEditingController();
  late String email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      //validator
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final resetrequest = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
         FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          Navigator.of(context).pop();
        },
        child: Text(
          "Send Request",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child:Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 200,
                              child: Image.asset("assets/images/logo_login.png",
                                  fit:BoxFit.contain)),
                          Text('Reset Password',
                            style: TextStyle(
                                fontSize: 35, fontFamily: 'Pushster', color: Colors.redAccent
                            ),
                          ),SizedBox(height: 45),
                          emailField,
                          SizedBox(height: 45),
                         resetrequest,
                          SizedBox(height: 45),

                        ],
                      )
                  ),
                ),
              ),
            ),
          ),
        );
  }
}