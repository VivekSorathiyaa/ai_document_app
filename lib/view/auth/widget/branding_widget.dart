import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_asset.dart';
import '../../../utils/client_review_widget.dart';
import '../../../utils/color.dart';

class BrandingWidget extends StatelessWidget {
  const BrandingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Grid with Opacity
          Opacity(
            opacity: .1,
            child: SvgPicture.asset(
              AppAsset.grid,
              width: double.infinity,
              fit: BoxFit.cover,
              color: primaryWhite.withOpacity(.2),
            ),
          ),

          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    // maxHeight: constraints.maxHeight,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Spacer(),
                      SvgPicture.asset(
                        AppAsset.logo,
                        width: 120,
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 58.0, vertical: 30),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: SelectableText(
                            'From Documents to AI\nConversation',
                            style: GoogleFonts.notoSans(
                              color: primaryWhite,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Spacer(),
                      ClientReviewWidget(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
