import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../e_commerce_app/presentation/pages/home_page.dart';
import '../bloc/authentication_bloc.dart';
import '../../../e_commerce_app/presentation/bloc/e_commerce_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'ECOM',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Color.fromARGB(255, 79, 43, 240),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthenticationAuthenticated) {
            _nameController.clear();
            _confirmPasswordController.clear();
            _passwordController.clear();
            _emailController.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Name', style: TextStyle(fontSize: 20)),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'ex: Jon Smith',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text('Email', style: TextStyle(fontSize: 20)),
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
                  const SizedBox(height: 15),
                  const Text('Password', style: TextStyle(fontSize: 20)),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
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
                  const SizedBox(height: 15),
                  const Text('Confirm Password',
                      style: TextStyle(fontSize: 20)),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: '********',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 79, 43, 240),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _signUp();
                        }
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'SIGN UP',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
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

  void _signUp() {
    context.read<AuthenticationBloc>().add(
          SignUpEvent(
            emial: _emailController.text, 
            name: _nameController.text,
            password: _passwordController.text,
          ),
        );
  }
}
