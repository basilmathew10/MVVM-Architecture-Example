import 'package:flutter/material.dart';
import 'package:mvvmarchitecture/Model/ViewModel.dart';
import 'package:mvvmarchitecture/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
   final GlobalKey<FormState> _key = GlobalKey<FormState>();
   late bool _obscurePassword;
  late bool _autovalidate;
   TextEditingController nameController= TextEditingController();
   TextEditingController phoneController= TextEditingController();
      TextEditingController addressController= TextEditingController();
   TextEditingController usernameController= TextEditingController();
      TextEditingController passwordController= TextEditingController();

   bool name_validate=false;
   bool phone_validate=false;
   bool address_validate=false;
   bool username_validate=false;
      bool password_validate=false;

   @override
 void dispose() {
  super.initState();
    _obscurePassword = true;
    _autovalidate = false;
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }
late var viewmodel;
   @override
  Widget build(BuildContext context) {
           viewmodel=Provider.of<ViewModel>(context);

     child: const SafeArea(minimum: EdgeInsets.all(16),
     child: Text(''),
 );
   return Scaffold(
     body: Center(
     
      child:_buildRegForm(),
     ),
     );
  }
      Widget _buildRegForm() {
      
    return Form(
      key: _key,
    
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
             Text(
                  'REGISTER ACCOUNT ',
                  textAlign: TextAlign.center,
                  // style:
                  //     GoogleFonts.openSans(color: Colors.black, fontSize: 35,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20),
                Text(
                  'Complete your Details',
                  textAlign: TextAlign.center,
                  // style:
                  //     GoogleFonts.openSans(color: Colors.grey, fontSize: 18,fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
              TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                filled: true,
                isDense: true,
              ),
              controller: nameController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'Name'),
            ),
            const SizedBox(
              height: 12,
            ),
          
                            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone No',
                filled: true,
                isDense: true,
              ),
              controller: phoneController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'Phone No'),
            ),
            const SizedBox(
              height: 12,
            ),

                  TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
                filled: true,
                isDense: true,
              ),
              controller: addressController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'Address'),
            ),
            const SizedBox(
              height: 12,
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
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
               validator: (val) => _validateRequired(val!, 'Password'),
            ),
            const SizedBox(
              height: 12,
            ),
              //     Padding(padding: const EdgeInsets.all(10),
              //     child: CupertinoRadioChoice(
              // choices: genderMap,
              // onChange: onGenderSelected,
              // initialKeyValue: _selectedGender)
              //     ),    
                  
            
            TextButton(
                onPressed: () async{
                  
                    // setState(() {
                    //   nameController.text.isEmpty ? name_validate = true : name_validate = false;
                    //   phoneController.text.isEmpty ? phone_validate = true : phone_validate = false;
                    //   addressController.text.isEmpty ? address_validate = true : address_validate = false;
                    //   usernameController.text.isEmpty ? username_validate = true : username_validate = false;
                    //   passwordController.text.isEmpty ? password_validate = true : password_validate = false;

                    // });
                     final bool success= _key.currentState!.validate();
                  if(success){
                    print('form is valid');
                    _key.currentState!.save();
                   String name=nameController.text; 
                   String phone=phoneController.text; 
                   String address=addressController.text; 
                   String username=usernameController.text; 
                   String password=passwordController.text;   

                    print("name =$name");
                    print("phone =$phone");
                   print("address =$address");
                   print("username =$username");
                   print("password =$password");


                   final success=await viewmodel.registrationdata(name, phone, address, username, password);

                      if (success) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('username', username);
                             Navigator.push(
                        context,
                        MaterialPageRoute (builder: (context) =>
                                const LoginPage()));
                          }
                      }
                },
    style: TextButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 1, 4, 36),
      textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
    ),
                child: const Text('Register'),
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Dont you have an Account?'),
                TextButton(
                  child: const Text(
                    'Login',
                  style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 1, 4, 36)),
                  ),
                  onPressed: () {

                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                              const LoginPage()));
                              
                  },
                )
              ],
            ),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
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
      return 'Enter valid username';
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