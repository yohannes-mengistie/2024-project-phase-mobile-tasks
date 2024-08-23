import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../e_commerce_app/presentation/bloc/e_commerce_bloc.dart';
import '../../../e_commerce_app/presentation/pages/home_page.dart';
import '../bloc/authentication_bloc.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationBloc,AuthenticationState>(
        listener:(context,state){
          if(state is AuthenticationAuthenticated){
             _confirmPasswordController.clear();
            _passwordController.clear();
            _emailController.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }else if( state is AuthenticationError){
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        
        },
        child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    //boxShadow: ,
                    border: Border.all(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal:10),
                    child: Text(
                      'ECOM',
                      style: TextStyle(
                          fontFamily: 'CaveatBrush',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 79, 43, 240)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Sign in to your account',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Email',
                style: TextStyle(fontSize: 16),
              ),
               TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'ex: jon.smith@email.com',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Password',
                style: TextStyle(fontSize: 16),
              ),
               TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '********',
                  border: OutlineInputBorder(),
                ),
                 validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 79, 43, 240), // Blue color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      context.read<AuthenticationBloc>().add(LogInEvent(emial: _emailController.text.trim(), password: _passwordController.text.trim()));
                      context.read<ECommerceBloc>().add(const LoadAllProductEvent());
                     
                    }
                    
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 150,),
              Center(
                child: RichText(
                  text:  TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'SIGN UP',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                         recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpPage()));
                            }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        ),
      ),
    );
  }
}
