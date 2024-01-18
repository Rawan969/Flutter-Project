import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/screens/login_page.dart';
import 'package:flutterproject/screens/widget/my_text_field.dart';


class SignUp extends StatefulWidget {
  static String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(SignUp.pattern);
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Variable to hold the message to be displayed
  String message = '';

  Future<void> sendData() async {
  try {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
    await FirebaseFirestore.instance
        .collection('userData')
        .doc(userCredential.user?.uid)
        .set({
      "firstName": firstName.text.trim(),
      "lastName": lastName.text.trim(),
      "email": email.text.trim(),
      "userid": userCredential.user?.uid,
      "password": password.text.trim(),
    });

    // Set success message
    setMessage("User registered successfully!");

    // Navigate to the login page after successful registration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      setMessage("The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      setMessage("The account already exists for that email");
    }
  } catch (e) {
    setMessage(e.toString());
  } finally {
    setState(() {
      loading = false;
    });
  }
}


  void validation() {
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      setMessage("firstName is Empty");
      return;
    }
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      setMessage("lastName is Empty");
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      setMessage("Email is Empty");
      return;
    } else if (!regExp.hasMatch(email.text)) {
      setMessage("Please enter valid Email");
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      setMessage("Password is Empty");
      return;
    } else {
      setState(() {
        loading = true;
      });
      sendData();
    }
  }

  void setMessage(String newMessage) {
    setState(() {
      message = newMessage;
    });
  }

  Widget messageWidget() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.red,
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget button({
    required String buttonName,
    required Color color,
    required Color textColor,
    @required VoidCallback? onPressed,
  }) {
   return Container(
  width: 120,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: onPressed,
    child: Text(
      buttonName,
      style: TextStyle(fontSize: 18, color: textColor),
    ),
  ),
);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextField(
                      controller: firstName,
                      obscureText: false,
                      hintText: 'firstName',
                    ),
                    MyTextField(
                      controller: lastName,
                      obscureText: false,
                      hintText: 'lastName',
                    ),
                    MyTextField(
                      controller: email,
                      obscureText: false,
                      hintText: 'Email',
                    ),
                    MyTextField(
                      controller: password,
                      obscureText: true,
                      hintText: 'password',
                    ),
                  ],
                ),
              ),
              loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(
                          onPressed: () {
                            // Clear the text fields on "Cancel"
                            firstName.clear();
                            lastName.clear();
                            email.clear();
                            password.clear();
                          },
                          buttonName: "Cancel",
                          color: Colors.grey,
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        button(
                          onPressed: () {
                            validation();
                          },
                          buttonName: "Register",
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
              // Display the message widget
              if (message.isNotEmpty) messageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
