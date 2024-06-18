import 'package:flutter/material.dart';
import 'package:mvvmarchitecture/Model/ViewModel.dart';
import 'package:mvvmarchitecture/homepage.dart';
import 'package:provider/provider.dart';
import 'package:mvvmarchitecture/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (BuildContext context) => ViewModel(),
      
      child: MaterialApp(
        title: 'Flutter MVVM Login',
        theme: ThemeData(primarySwatch: Colors.blue),
         home: const LoginPage(),
        // Define other routes if needed
        routes: {
          '/home': (context) => const MyHomePage(title: '',),
          // Other routes...
        },
      ),
    );
  }
}






