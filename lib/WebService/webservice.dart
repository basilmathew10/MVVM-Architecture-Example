import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mvvmarchitecture/Model/categorymodel.dart';
import 'package:mvvmarchitecture/Model/poductmodel.dart';

class Webservice{
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  static const mainurl = 'http://bootcamp.cyralearnings.com/';






  login(String username,String password) async{
    try{
      print(username);
      print(password);
      var result;
      final Map<String,dynamic> loginData = {

        'username': username,
        'password': password,
      };
        final response = await http.post(Uri.parse("${Webservice.mainurl}login.php"),
        body: loginData,
        );
        // print(response.statusCode);
        
       if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          // log("login successfully completed");
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setBool("isLoggedIn", true);
          // prefs.setString("username", username);
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) {
          //     return MyHomePage(title: '');
          //   },
          // ));
                    // result = {log(json.decode(response.body)['success'].toString())};
return true;
          }
          else{
            log("login failed");

          //  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed"))); 
return false;
                    // result = {log(json.decode(response.body)['error'].toString())};

          }
        }
        else{
          // result = {log(json.decode(response.body)['error'].toString())};
          
        }
        return false;
        // return result;
    }
    catch (e) {
      log(e.toString());
    }
  }





registration( name, phone, address, username, password) async{
    try{
      print(username);
      print(password);
      var result;
      final Map<String,dynamic> registrationData = {
        'name': name,
        'phone': phone,
        'address': address,
        'username': username,
        'password': password,
      };
        final response = await http.post(Uri.parse("${Webservice.mainurl}registration.php"),
        body: registrationData
        );
        print("code :${response.statusCode}");
        
        if(response.statusCode==200){
          print("result:${response.body}");
          if(response.body.contains("success")){
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Success")));
            // Navigator.push(context, MaterialPageRoute(builder: (context){
            //   return LoginPage(title: '',);
            // },
            // ));
              return true;
            // result = {log(json.decode(response.body)['success'].toString())};
          }
          else{
             log("login failed");
                         print(response.body);
return false;
          //  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Failed"))); 
          //result = {log(json.decode(response.body)['error'].toString())};

          }
        }
        else{
          //result = {log(json.decode(response.body)['error'].toString())};
        }
        return false;
                  // return result;

    }
    catch (e) {
      log(e.toString());
    }
  }






Future<List<CategoryModel>>fetchCategory() async {
   
      final response = await http.post(Uri.parse('http://bootcamp.cyralearnings.com/getcategories.php'));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<CategoryModel>((json) => CategoryModel.fromMap(json)).toList();
      } else {
        throw Exception('Failed to load category');
      }
   
  }





    Future<List<ProductModel>> fetchPost() async {
                                                    
                                                    final response =
                                                        await http.post(Uri.parse('http://bootcamp.cyralearnings.com/view_offerproducts.php'));
                                                        
                                                    if (response.statusCode == 200) {
                                                      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
                                                      return parsed.map<ProductModel>((json) => ProductModel.fromMap(json)).toList();
                                                    } else {
                                                      throw Exception('Failed to load album');
                                                    }
                                                  }







}