import 'package:doflow/Utils/color_contstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final String name;
  final bool isEnabled;

  const CustomLoginButton({
    super.key,
    required this.name,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          isEnabled
              ? ColorConstants.MainWhite
              : ColorConstants.MainWhite.withOpacity(0.5),
        ),
        backgroundColor: WidgetStatePropertyAll(
          isEnabled
              ? ColorConstants.BlueButton
              : ColorConstants.BlueButton.withOpacity(0.5),
        ),
        minimumSize: WidgetStatePropertyAll(Size(double.infinity.w, 48.h)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
      ),
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        name,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
