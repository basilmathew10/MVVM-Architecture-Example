import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mvvmarchitecture/Model/categorymodel.dart';
import 'package:mvvmarchitecture/Model/poductmodel.dart';
import 'package:mvvmarchitecture/Webservice/webservice.dart';
import 'package:mvvmarchitecture/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<ProductModel>> futurePost;
  late Future<List<CategoryModel>> futureCategory;

  @override
  void initState() {
    super.initState();
    futurePost = Webservice().fetchPost();
    futureCategory = Webservice().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'E-COMMERCE',
          style:TextStyle(color:Color.fromARGB(255, 238, 238, 242)),
        ),
              backgroundColor: const Color.fromARGB(255, 4, 1, 36),

      ),
       drawer: Drawer(  
        
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        
        children: [
        
         const Divider(
          height: 1,
          thickness: 1,
         ),
          const SizedBox(
            height: 50,
          ),
                  
            const Text(
                   "E-COMMERCE",
                    textAlign:TextAlign.center ,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Color.fromARGB(255, 4, 1, 36),), 
                  ),
              const SizedBox(
            height: 30,
          ),
                  const Divider(
                    height: 2,
                    thickness: 2,
                  ),
        
                            const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size:30 ,
            ),
            title: const Text(
                    "Home",
                    style: TextStyle( fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 4, 1, 36)),
                  ), 
                   trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
                  onTap: () {
                                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MyHomePage(title: '',
                      
                      ),
                    ),
              );

                  },
          ),
          const SizedBox(
            height: 10,
          ),
          //  ListTile(
          //     leading: badges.Badge(
          //         showBadge:
          //             //  true,
          //             context.read<Cart>().getItems.isEmpty ? false : true,
          //         badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
          //         badgeContent: Text(
          //           context.watch<Cart>().getItems.length.toString(),
          //           style: const TextStyle(
          //               fontSize: 10,
          //               fontWeight: FontWeight.w600,
          //               color: Colors.white),
          //         ),
          //         child: const Icon(
          //           Icons.shopping_cart,
          //           color: Colors.grey,
          //           // size: 15,
          //         )),
          //     //const Icon(Icons.shopping_cart),
          //     title: const Text(
          //       'Cart page',
          //      style: TextStyle( fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 4, 1, 36),),
          //     ),
          //     trailing: Icon(
          //       Icons.arrow_forward_ios_rounded,
          //       size: 15,
          //     ),
          //     onTap: () {
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(builder: (context) => CartPage()),
          //       // );
          //     },
          //   ),
                    
                    
                 
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.book_online,
              size: 30,
            ),
            title: const Text(
                    "Order Deatils",
                    
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 4, 1, 36),),
                  ),
                   trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
            onTap: () {
              // Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute<void>(
              //         builder: (BuildContext context) => OrderDetails(),
              //       ),
              //     );
               },
          ),
                    const SizedBox(
            height: 10,
          ),
                            const Divider(
                    height: 2,
                    thickness: 2,
                  ),
         

          ListTile(
            leading: const Icon( 
              Icons.power_settings_new_rounded,
              size: 30,
            ),
                        title: const Text(
                    "Logout",
                    
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 4, 1, 36),),
                  ),
                   trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
                  
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            
          ),

                      const Divider(
                    height: 1,
                    thickness: 1,
                  ),

        ],
      ),
       
    ),

      body: Center(
        child: _buildHomePage(),
      ),
    );
  }

  Widget _buildHomePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            'Category',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder(
          future: futureCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                       onTap: () {
                          log("clicked");

                         Navigator.push(context, MaterialPageRoute(
                           builder: (context) {
                             return const LoginPage();
                            //  Category_productsPage(
                            //    //  catid: ,catname: ,
                            //    catid: snapshot.data![index].id!,
                            //    catname: snapshot.data![index].category!,
                            //  );
                           },
                         ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(37, 5, 2, 39),
                          ),
                          child: Center(
                            child: Text(
                              snapshot.data![index].category!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),



        
                                                    Container(
                                                      padding: const EdgeInsets.all(16),
                                                      child: const Text(
                                                        "Offer Products",
                                                        style: TextStyle(
                                                          fontSize: 23,
                                                          color: Color.fromARGB(255, 4, 1, 36),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                      
                                                      
                                                        Expanded(
                                                          child: FutureBuilder<List<ProductModel>>(
                                                            future: futurePost,
                                                            builder: (context, snapshot) {
                                                              if (snapshot.hasData) {
                                                                return GridView.builder(
                                                                  physics: const BouncingScrollPhysics(),
                                                                  shrinkWrap: true,
                                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount: 2,
                                                                    crossAxisSpacing: 8,
                                                                    mainAxisSpacing: 8,
                                                                  ),
                                                                  itemCount: snapshot.data!.length,
                                                                  itemBuilder: (BuildContext context, int index) {
                                                                    final post = snapshot.data![index];
                                                                    return Container(
                                                                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                                      padding: const EdgeInsets.all(20.0),
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          AspectRatio(
                                                                            aspectRatio: 3 / 2,
                                                                            child: GestureDetector(
                                                                                onTap: () {
                                                                                                            Navigator.of(context).push(
                                                                                                              MaterialPageRoute(
                                                                                                                builder: (context) => const LoginPage()
                                                //                                                          (product: post,
                                                //                                           //                       id: post.id,
                                                //                                           // name: post.prodname,
                                                //                                           // image:"http://bootcamp.cyralearnings.com/products/${post.image}",
                                                //                                           // price: post.price.toString(),
                                                //                                           // description: post.description), 
                                                                                                              ),
                                                                                                            );
                                                                                                      },
                                                                              child: Image.network(
                                                                                "http://bootcamp.cyralearnings.com/products/${post.image}",
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            snapshot.data![index].prodname,
                                                                            style: const TextStyle(
                                                                              fontSize: 16.0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "Rs:${snapshot.data![index].price}",
                                                                            style: TextStyle(
                                                                              color: Colors.red.shade900,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              } else {
                                                                return const Center(child: CircularProgressIndicator());
                                                              }
                                                            },
                                                          ),
                                                        ),
      ],
    );
  }
}