import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../utils/app_asset.dart';
import '../utils/client_review_widget.dart';
import '../utils/color.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            rowCrossAxisAlignment: CrossAxisAlignment.start,
            layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              // if (ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP))
              ResponsiveRowColumnItem(
                rowFlex: 1,
                child: Container(
                    width: double.infinity,
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
                      // scrollDirection: Axis.vertical,
                      // mainAxisSize: MainAxisSize.min, // Prevent infinite height
                      children: [
                        SizedBox(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Opacity(
                                opacity: .1,
                                child: SvgPicture.asset(
                                  AppAsset.grid,
                                  width: double.infinity,
                                  height: constraints.maxHeight,
                                  fit: BoxFit.cover,
                                  color: primaryWhite.withOpacity(.2),
                                ),
                              ),
                              ListView(
                                // mainAxisSize:
                                //     MainAxisSize.min, // Minimize column size
                                children: [
                                  SizedBox(
                                    height: ResponsiveValue(
                                      context,
                                      defaultValue: 109.0,
                                      conditionalValues: const [
                                        Condition.smallerThan(
                                            name: MOBILE, value: 60.0),
                                        Condition.smallerThan(
                                            name: TABLET, value: 80.0),
                                      ],
                                    ).value,
                                  ),
                                  SvgPicture.asset(
                                    AppAsset.logo,
                                    width: ResponsiveValue(
                                      context,
                                      defaultValue: 220.0,
                                      conditionalValues: const [
                                        Condition.smallerThan(
                                            name: MOBILE, value: 120.0),
                                        Condition.smallerThan(
                                            name: TABLET, value: 180.0),
                                      ],
                                    ).value,
                                    height: ResponsiveValue(
                                      context,
                                      defaultValue: 220.0,
                                      conditionalValues: const [
                                        Condition.smallerThan(
                                            name: MOBILE, value: 120.0),
                                        Condition.smallerThan(
                                            name: TABLET, value: 180.0),
                                      ],
                                    ).value,
                                  ),
                                  SizedBox(
                                    height: ResponsiveValue(
                                      context,
                                      defaultValue: 54.0,
                                      conditionalValues: const [
                                        Condition.smallerThan(
                                            name: MOBILE, value: 30.0),
                                        Condition.smallerThan(
                                            name: TABLET, value: 40.0),
                                      ],
                                    ).value,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 58.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'From Documents to AI\nConversation',
                                        style: GoogleFonts.notoSans(
                                          color: primaryWhite,
                                          fontSize: ResponsiveValue(
                                            context,
                                            defaultValue: 40.0,
                                            conditionalValues: const [
                                              Condition.smallerThan(
                                                  name: MOBILE, value: 24.0),
                                              Condition.smallerThan(
                                                  name: TABLET, value: 32.0),
                                            ],
                                          ).value,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  ClientReviewWidget(),
                                  SizedBox(
                                    height: ResponsiveValue(
                                      context,
                                      defaultValue: 90.0,
                                      conditionalValues: const [
                                        Condition.smallerThan(
                                            name: MOBILE, value: 40.0),
                                        Condition.smallerThan(
                                            name: TABLET, value: 60.0),
                                      ],
                                    ).value,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),

              // ResponsiveRowColumnItem(
              //   rowFlex: 1,
              //   child: SingleChildScrollView(
              //     child: Container(
              //       padding: const EdgeInsets.all(32.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           FittedBox(
              //             fit: BoxFit.scaleDown,
              //             child: const Text('Login',
              //                 style: TextStyle(
              //                     fontSize: 30, fontWeight: FontWeight.bold)),
              //           ),
              //           const SizedBox(height: 10),
              //           FittedBox(
              //             fit: BoxFit.scaleDown,
              //             child: FittedBox(
              //               fit: BoxFit.scaleDown,
              //               child: const Text('Glad you\'re back!',
              //                   style: TextStyle(fontSize: 16)),
              //             ),
              //           ),
              //           const SizedBox(height: 30),
              //           TextFormField(
              //             decoration: InputDecoration(
              //               hintText: 'Email',
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10)),
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           TextFormField(
              //             obscureText: true,
              //             decoration: InputDecoration(
              //               hintText: 'Password',
              //               border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(10)),
              //               suffixIcon: const Icon(Icons.visibility_off),
              //             ),
              //           ),
              //           const SizedBox(height: 30),
              //           ElevatedButton(
              //             onPressed: () {},
              //             child: FittedBox(
              //                 fit: BoxFit.scaleDown, child: const Text('Log in')),
              //           ),
              //           const SizedBox(height: 20),
              //           FittedBox(
              //               fit: BoxFit.scaleDown,
              //               child:
              //                   const Text('Or', style: TextStyle(fontSize: 16))),
              //           const SizedBox(height: 20),
              //           // ElevatedButton(
              //           //   onPressed: () {},
              //           //   child: Icon(Icons.logo),
              //           // ),
              //           const SizedBox(height: 20),
              //           FittedBox(
              //               fit: BoxFit.scaleDown,
              //               child: const Text('Don\'t have an account?')),
              //           TextButton(
              //             onPressed: () {},
              //             child: const Text('Signup'),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
