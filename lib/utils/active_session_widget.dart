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
                          style: AppTextStyle.normalRegular16
                              .copyWith(color: tableTextColor),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
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
