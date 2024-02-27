import 'package:firabsenew/Firebase%20example/Registretation%20page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Firebase helper.dart';
import 'home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDsAPspfyD2zW4FgJL_WyAIUsV7YqTwGSM",
        ///current key in google service json
        appId:  "1:909780237289:android:77edd69f7f8afe4e682978",
        ///mobilesdkappid in google service json
        messagingSenderId: '',
        projectId: "fir-example-d1543")
        ///projectid in google service json
  );
 User?user=FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user==null?
    login():home()
  ));
}

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    var email_controller=TextEditingController();
    var pass_controller=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase login"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: TextField(
              controller: email_controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: TextField(
              controller: pass_controller,
              decoration: InputDecoration(
                  hintText: "password", border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 150, left: 150),
            child: ElevatedButton(onPressed: () {
              String email=email_controller.text.trim();
              String pass=pass_controller.text.trim();

              FireBaseHelper()
              .loginUser(email: email,pwd: pass)
              .then((result){
                if(result==null){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.blue,
                      content: Text(result)));
                }
              });

            }, child: Text("Login")),
          ),
          TextButton(onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>register()));
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
