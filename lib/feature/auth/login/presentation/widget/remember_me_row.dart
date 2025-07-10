import 'package:flutter/material.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';
import 'package:foodia_chef/feature/auth/forgotPassword/presentation/screen/forgotPassword_screen.dart';


class RememberMeRow extends StatefulWidget {
  final ValueChanged<bool> onRememberChanged;

  const RememberMeRow({super.key, required this.onRememberChanged});

  @override
  State<RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isRememberMe,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value ?? false;
                });
                widget.onRememberChanged(isRememberMe);
              },
              activeColor: Color(0xff000000),
              checkColor: Colors.white,
              side: const BorderSide(color: Color(0xff000000)),
            ),
            Text(
              AppStrings.rememberMe,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFA500),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed:() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotpasswordScreen(),
      ),
    );
  },
          child: Text(
            AppStrings.forgotPassword,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
