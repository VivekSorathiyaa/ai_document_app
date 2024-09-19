import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/static_decoration.dart';

class HomeView extends StatelessWidget {
  static const String name = 'home';
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    orangeColor,
                    purpleColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  customHeight(109),
                  SvgPicture.asset(
                    AppAsset.logo,
                    width: 200,
                    height: 200,
                    color: primaryWhite,
                  ),
                  customHeight(54),
                  Text(
                    'LOREM IPSUM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'From Documents to AI\nConversation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  // Expanded(
                  //   child: GridView.count(
                  //     crossAxisCount:
                  //         ResponsiveBreakpoints.of(context).isMobile
                  //             ? 2
                  //             : ResponsiveBreakpoints.of(context).isTablet
                  //                 ? 3
                  //                 : 4,
                  //     children: List.generate(
                  //       12,
                  //       (index) {
                  //         return Card(
                  //           child: Container(
                  //             padding: EdgeInsets.all(16),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 FlutterLogo(),
                  //                 // SizedBox(height: 10),
                  //                 // Text(
                  //                 //   'Our happy customer',
                  //                 //   style: TextStyle(
                  //                 //     fontSize: 16,
                  //                 //     fontWeight: FontWeight.bold,
                  //                 //   ),
                  //                 // ),
                  //                 // SizedBox(height: 5),
                  //                 // Text(
                  //                 //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.',
                  //                 //   style: TextStyle(
                  //                 //     fontSize: 12,
                  //                 //   ),
                  //                 // ),
                  //                 // SizedBox(height: 5),
                  //                 // Row(
                  //                 //   children: [
                  //                 //     Icon(Icons.star),
                  //                 //     Icon(Icons.star),
                  //                 //     Icon(Icons.star),
                  //                 //     Icon(Icons.star),
                  //                 //     Icon(Icons.star_half),
                  //                 //   ],
                  //                 // ),
                  //                 // SizedBox(height: 5),
                  //                 // Text(
                  //                 //   'Patricia Ordaz',
                  //                 //   style: TextStyle(
                  //                 //     fontSize: 12,
                  //                 //   ),
                  //                 // ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Glad you\'re back!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: const Icon(Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF56B97),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 40,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Log in'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 40,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const FlutterLogo(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Signup',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terms & Conditions',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Customer Care',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
