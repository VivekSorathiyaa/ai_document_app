import 'package:ai_document_app/utils/app_text_style.dart';
import 'package:ai_document_app/utils/static_decoration.dart';
import 'package:flutter/cupertino.dart';

import 'color.dart';

class ActiveSessionWidget extends StatelessWidget {
  const ActiveSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Row(
          children: [
            const Icon(
              CupertinoIcons.desktopcomputer,
              color: primaryWhite,
            ),
            customWidth(20),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "2018 Macbook Pro 15-inch",
                          style: AppTextStyle.normalBold16
                              .copyWith(color: tableTextColor),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      width08,
                      Container(
                        decoration: BoxDecoration(
                          color: primaryWhite,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          child: Row(
                            children: [
                              Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: greenColor),
                              ),
                              width05,
                              Text(
                                "Active Now",
                                style: AppTextStyle.normalSemiBold12
                                    .copyWith(color: primaryBlack),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  customHeight(5),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Melbourne, Australia • 22 Jan at 10:40am",
                          style: AppTextStyle.normalRegular14
                              .copyWith(color: tableTextColor),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
