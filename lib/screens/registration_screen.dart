import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeapp/model/user_model.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  // formkey
  final formKey = GlobalKey<FormState>();

  //editting controller
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController secondNameController =
      new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
//Firsname field
    final firstnameField = TextFormField(
      autofocus: false,
      controller: firstNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if( value!.isEmpty){
          return("First Name cannot be Empty");
        }
        if(!regex.hasMatch(value)){
          return ("Enter Valid name(Min.3 Character)");
        }
        return null;

      },
      onSaved: (value) {
        firstNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
// second field
    final secondnameField = TextFormField(
      autofocus: false,
      controller: secondNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if( value!.isEmpty){
          return("Second Name cannot be Empty");
        }
          return null;
      },
      onSaved: (value) {
        secondNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
// email field
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return("Please Enter a valid email");
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
//password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: _obscureText,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if( value!.isEmpty){
          return("Password is required for login");
        }
        if(!regex.hasMatch(value)){
          return ("Please Enter Valid Password(Min.6 Character)");
        }

      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Pass word",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: (value) {
        passwordController.text = value!;
      },
    );
//confirm field
    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value){
        if(confirmPasswordController.text!=passwordController.text){
          return "Pass word don't match";

        }
        return null;

      },
      controller: confirmPasswordController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },
    );
// signUp button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: Text(
          " Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(

              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/images/logo_login.png",
                          fit: BoxFit.contain),
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Pushster',
                          color: Colors.redAccent),
                    ),
                    SizedBox(height: 35),
                    firstnameField,
                    SizedBox(height: 30),
                    secondnameField,
                    SizedBox(height: 30),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 25),
                    confirmPasswordField,
                    SizedBox(height: 35),
                    signUpButton,
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      );
  }
  // sing up
void signUp(String email, String password) async{
    if(formKey.currentState!.validate())
      {
        await _auth.createUserWithEmailAndPassword(email: email, password: password)
            .then((value) =>{
            postDetailsToFirestore()
        }).catchError((e){
          Fluttertoast.showToast(msg: e!.message);
        });
      }
}
  postDetailsToFirestore() async
  {
     FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
     User? user= _auth.currentUser;
     UserModel userModel= UserModel();
     userModel.email= user!.email;
     userModel.firstName= firstNameController.text;
     userModel.secondName= secondNameController.text;

     await firebaseFirestore
       .collection("users")
       .doc(user.uid)
       .set(userModel.toMap());
     Fluttertoast.showToast(msg: "Account created successfuly");
     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
}
