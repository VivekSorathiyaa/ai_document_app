import 'package:ai_document_app/controllers/user_controller.dart';
import 'package:ai_document_app/utils/app_asset.dart';
import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/primary_text_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserHeaderWidget extends StatelessWidget {
  final UserController userController;

  UserHeaderWidget({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return Padding(
      padding: EdgeInsets.only(
          bottom:
              ResponsiveBreakpoints.of(context).smallerThan(DESKTOP) ? 0 : 40,
          top: 4),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                      ? 20
                      : 0),
              child: Text(
                "All Users",
                style: AppTextStyle.normalSemiBold18.copyWith(
                    fontSize:
                        ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                            ? 14
                            : 18),
                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
              ),
            ),
          ),

          // Button Section
          ResponsiveRowColumnItem(
            rowFlex: 2,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 474),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filters Button
                  Expanded(
                    flex: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                        ? 3
                        : 2,
                    child: PrimaryTextButton(
                      title: "Filters",
                      fontSize: isDesktop ? null : 14,
                      onPressed: () {
                        userController.showFilterDialog();
                      },
                      height: ResponsiveValue<double>(
                        context,
                        defaultValue: 45.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 40.0),
                        ],
                      ).value!,
                      icon: AppAsset.filter,
                    ),
                  ),
                  SizedBox(
                    width: ResponsiveValue<double>(
                      context,
                      defaultValue: 24.0,
                      conditionalValues: [
                        const Condition.smallerThan(name: DESKTOP, value: 16.0),
                      ],
                    ).value!,
                  ),
                  // Upload New Documents Button
                  Expanded(
                    flex: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                        ? 5
                        : 3,
                    child: PrimaryTextButton(
                      title: "Add New",
                      fontSize: isDesktop ? null : 14,
                      onPressed: () {},
                      height: ResponsiveValue<double>(
                        context,
                        defaultValue: 45.0,
                        conditionalValues: [
                          const Condition.smallerThan(
                              name: DESKTOP, value: 40.0),
                        ],
                      ).value!,
                      icon: AppAsset.plus,
                    ),
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
