import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_asset.dart';

Widget NoDataWidget() {
  return Container(
    width: double.infinity,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 165.0),
      child: SvgPicture.asset(AppAsset.power),
    ),
  );
}
