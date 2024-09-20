import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/app_asset.dart';
import '../../utils/client_review_widget.dart';
import '../../utils/color.dart';
import '../../utils/static_decoration.dart';

ResponsiveRowColumnItem BrandingWidget(
    {required BoxConstraints constraints, required BuildContext context}) {
  return ResponsiveRowColumnItem(
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
                      customHeight(109),
                      SvgPicture.asset(
                        AppAsset.logo,
                        width: ResponsiveValue(
                          context,
                          defaultValue: 220.0,
                          conditionalValues: const [
                            Condition.smallerThan(name: MOBILE, value: 120.0),
                            Condition.smallerThan(name: TABLET, value: 180.0),
                          ],
                        ).value,
                        height: ResponsiveValue(
                          context,
                          defaultValue: 220.0,
                          conditionalValues: const [
                            Condition.smallerThan(name: MOBILE, value: 120.0),
                            Condition.smallerThan(name: TABLET, value: 180.0),
                          ],
                        ).value,
                      ),
                      customHeight(54),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 58.0),
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
                      customHeight(110),
                      ClientReviewWidget(),
                      customHeight(90),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
  );
}
