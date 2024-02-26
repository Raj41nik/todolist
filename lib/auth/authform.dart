import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //------------data member--------------//
  final _formkey=GlobalKey<FormState>();
  var _email='';
  var _password='';
  var _username='';
  bool islogin= false;
  //------------------------------------//
  Startauth()async{
  final validity= _formkey.currentState!.validate();
  FocusManager.instance.primaryFocus?.unfocus();
  if(validity){
    _formkey.currentState!.save();
    submitform(_email, _password, _username);}
  }
  submitform(String email,String password,String username) async {
    final auth =FirebaseAuth.instance;
    UserCredential authResult;
    try{
      if(islogin){
       authResult= await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else{
        authResult= await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid=authResult.user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "username" : username,
          "email" : email,
          "password" : password,
        });
      }
    }
    catch(ex){
    print(ex);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentiation'),),

      body:Center(
        child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              height: 120,
              child: Image.asset('assets/1.png'),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Form(key:_formkey,child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(!islogin)
                  TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('Username'),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Incorrect Username';
                    }
                    return null;
                  },
                  onSaved:(value){
                    _username= value!;
                  } ,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide()),
                      labelText:'Enter Username',
                      labelStyle: GoogleFonts.roboto()
                  ),
                ),
                  SizedBox(height: 10,),
                  TextFormField(
                keyboardType: TextInputType.emailAddress,
                key: ValueKey('E-mail'),
                validator: (value){
                  if(value!.isEmpty || !value!.contains('@')){
                    return 'Incorrect email';
                  }
                  return null;
                },
                onSaved:(value){
                  _email= value!;
                } ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide: new BorderSide()),
                  labelText:'Enter E-mail',
                  labelStyle: GoogleFonts.roboto()
                ),
              ),
                  SizedBox(height: 10,),
                  TextFormField(
                    obscureText:true,
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('Password'),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Incorrect Password';
                      }
                      return null;
                    },
                    onSaved:(value){
                      _password= value!;
                    } ,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide()),
                        labelText:'Enter Password',
                        labelStyle: GoogleFonts.roboto()
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 70,
                    //color: Color(0xffa1c4fd),
                    child: ElevatedButton(
                      onPressed:(){
                      Startauth();
                    },
                      style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffa1c4fd))),
                      child: islogin?Text('Login',style: GoogleFonts.roboto(fontSize: 16),):Text('Sign Up',style: GoogleFonts.roboto(fontSize: 16)),

                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child:TextButton(
                      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(0xffa1c4fd))),
                      onPressed: () {
                      setState(() {
                        islogin=!islogin;
                      });
                    }, child:islogin?Text('Not a member ?',style: GoogleFonts.roboto(fontSize: 16,),): Text("Already a member ",style: GoogleFonts.roboto(fontSize: 16)),)
                  )
              ],),),
            )
          ],
        ),
    ),
      ),

    );
  }
}
