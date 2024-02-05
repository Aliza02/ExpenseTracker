import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  const appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AppColors.cream,
      // elevation: 0.0,
      forceMaterialTransparency: true,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blue,
          size: 30.0,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Get.height * 0.08);
}
