import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/data/model/user_model.dart';
import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../../../authentication/presentation/pages/sign_in_page.dart';
import '../bloc/e_commerce_bloc.dart';
import '../widgets/home_page_card.dart';
import 'create_page.dart';

import 'search_page.dart';

class HomePage extends StatelessWidget {
  //final detail;
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<ECommerceBloc>().add(LoadAllProductEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: PopupMenuButton<String>(
          onSelected:(value){
            switch(value){
              case 'profile':
                print('profile clicked');
                break;

              case 'settings':
                print('setting clicked');
                break;
              
              case 'LogOut':
                (context).read<AuthenticationBloc>().add(LogOutEvent());
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const SignInPage()));
                break;

            }
          },

          itemBuilder: (BuildContext context){
            return [
              const PopupMenuItem<String>(value: 'profile',child: Text(
                'profile'
              )),
              const PopupMenuItem(value:'settings',child: Text(
                'setting'
              )),

              const PopupMenuItem(value:'LogOut',child: Text(
               'LogOut'
              ))
            ];
          },
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 194, 192, 192),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        
        ),
        
        title: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      'July 14, 2023',
      style: TextStyle(fontSize: 14, color: Colors.grey),
    ),
    BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Hello, ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                TextSpan(
                  text: state.user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        } else if (state is AuthenticationLoading) {
          return const CircularProgressIndicator();
        } else if (state is AuthenticationError) {
          return Text(
            state.message,
            style: const TextStyle(color: Colors.red),
          );
        } else {
          return const Text(
            "User not authenticated",
            style: TextStyle(color: Colors.grey),
          );
        }
      },
    ),
  ],
),
        actions: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      print("Notification Button");
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Color.fromARGB(221, 94, 92, 92),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 17,
                right: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ECommerceBloc, ECommerceState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedAllProductState) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Available Products",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.search, color: Colors.grey),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchProductPage()));
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final item = state.products[index];
                        return HomeProductCard(data: item);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ErrorState) {
            return Center(child: Text(state.message));
          } else {
            print(state);
            return const Center(child: Text('No products found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProductPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 79, 43, 240),
      ),
    );
  }
}
