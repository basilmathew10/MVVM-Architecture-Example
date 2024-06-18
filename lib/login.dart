import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvmarchitecture/Model/ViewModel.dart';
import 'package:mvvmarchitecture/homepage.dart';
import 'package:mvvmarchitecture/registration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late bool _obscurePassword;
  late bool _autovalidate;
   TextEditingController usernameController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  late bool username_validate = false;
   late bool password_validate = false;

  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    _autovalidate = false;
    usernameController = TextEditingController();
    passwordController = TextEditingController();
            _loadCounter();

  }
  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = $isLoggedIn");
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyHomePage(title: '',)));
    }
  }
  late var viewmodel;
  @override
  Widget build(BuildContext context) {
       viewmodel=Provider.of<ViewModel>(context);

     return Scaffold(
     body: Center(
     
      child:_buildLoginForm(),
     ),
     );
  }

  Widget _buildLoginForm() {
          

    return Form(
      key: _key,
    
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
                  'WELCOME BACK',
                  textAlign: TextAlign.center,
                  // style:
                  //     GoogleFonts.openSans(color: Colors.black, fontSize: 35,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Login with your username and password',
                  textAlign: TextAlign.center,
                  // style:
                  //     GoogleFonts.openSans(color: Colors.grey, fontSize: 18,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                filled: true,
                isDense: true,
              ),
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'Username'),

            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                filled: true,
                isDense: true,
              ),
              obscureText: _obscurePassword,
              controller: passwordController,
              validator: (val) => _validateRequired(val!, 'Password'),
            ),
            const SizedBox(
              height: 16,
            ),
             
          TextButton(
  onPressed: () async {
    final bool success = _key.currentState!.validate();
    if (success) {
      print('Form is valid');
      _key.currentState!.save();
      String username = usernameController.text;
      String password = passwordController.text;

      print("username = $username");
      print("password = $password");

      if (username.isNotEmpty && password.isNotEmpty) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("username", username);
        String sessionUsername = pref.getString("username").toString(); // Use null-aware operator to handle null case
        print(sessionUsername);

         viewmodel.logindata(username, password).then((value){
        
        if (value==true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage(title: '',)),
          );
        } else {
          // Show error message or handle unsuccessful login
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed"))); 
          // print('login failed');
        }
      });
    }
    }
  },
  style: TextButton.styleFrom(
    foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 1, 4, 36),
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  child: const Text('Login'),
),


               Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Dont have an account?'),
                TextButton(
                  child: const Text(
                    'Go to Register',
                    style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 1, 4, 36)),
                    
                  ),
                  onPressed: () {

                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                              const RegistrationPage()));
                              
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
     }
            
  String? _validateRequired(String val, fieldName) {
    if (val == '') {
      return '$fieldName is required';
    }
    
    return null;
  }

  String? _validateEmail(String value) {
    if (value == '') {
      return 'Email is required';
    }
  

    var regex;
    if (!regex.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }

  void _validateFormAndLogin() {
    // Get form state from the global key
    var formState = _key.currentState;

    // check if form is valid
    if (formState!.validate()) {
      print('Form is valid');
    } else {
      // show validation errors
      // setState forces our [State] to rebuild
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
