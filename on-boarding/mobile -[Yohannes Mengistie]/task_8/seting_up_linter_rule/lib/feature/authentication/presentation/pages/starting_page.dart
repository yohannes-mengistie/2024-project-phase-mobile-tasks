import 'package:flutter/material.dart';

import 'sign_in_page.dart';
import 'sign_up_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
        children: [ 
                  
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 79, 43, 240),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
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
                

                 ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 79, 43, 240), // Blue color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                    
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              


        ],
       ),
      ),
    );
  }
}