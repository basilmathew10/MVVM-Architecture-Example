import 'package:flutter/material.dart';
import 'package:mvvmarchitecture/Model/categorymodel.dart';
import 'package:mvvmarchitecture/Model/poductmodel.dart';
import 'package:mvvmarchitecture/WebService/webservice.dart';

class ViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> logindata(String username, String password) async {
    _isLoading = true;
   // notifyListeners();

    try {
      final bool loginResult = await Webservice().login(username, password);

      if (loginResult) {
        print("login result");
        // Successful login
        return true;
      } else {
        // Handle login failure
        print('Login failed');
        return false;
      }
    } catch (e) {
      // Handle error
      print('Login failed: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registrationdata(
      String name, String phone, String address, String username, String password) async {
    _isLoading = true;
    //notifyListeners();
 late  Map<String,dynamic> registrationResult;
    try {
       bool t = await Webservice().registration(name, phone, address, username, password);
    return t;

// print(registrationResult);
//       if (registrationResult.toString().contains("success")) {
//         // Successful registration
//         return true;
//       print('registration success');
//       } else {
//         return false;
//         // Handle registration failure
//         print('Registration failed');
//         // return false;
//       }
      
    } catch (e) {
      // Handle error
      print('Registration failed: $e');
      // return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
 return false;
    
     
  }





  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;
  Future<void> fetchPostdata() async {

    _isLoading = true;

    try {
      _products = await Webservice().fetchPost();
    } catch (e) {
      // Handle error
      print('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  List<CategoryModel> _category = [];

  // List<CategoryModel> get category => _category;
  Future<void> fetchCategorydata() async {

    _isLoading = true;

    try {
      _category = await Webservice().fetchCategory();
    } catch (e) {
      // Handle error
      print('Error fetching category: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



}
