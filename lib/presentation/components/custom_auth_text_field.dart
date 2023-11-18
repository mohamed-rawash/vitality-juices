import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
class CustomAuthTextField extends StatelessWidget {
  const CustomAuthTextField({super.key, required this.title, this.show, required this.controller, this.validator});

  final String title;
  final bool? show;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onTapOutside: (e) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          labelText: title,
          floatingLabelStyle: textFieldLabelStyle(),
          labelStyle: textFieldLabelStyle(),
          enabledBorder: buildSearchTextInputBorder(),
          focusedBorder: buildSearchTextInputBorder(),
          errorBorder: buildSearchTextInputBorder(),
          focusedErrorBorder: buildSearchTextInputBorder(),
          errorStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            color: Colors.red,
          )
        ),
        obscureText: show ?? false,
        obscuringCharacter: "*",
        style: textFieldLabelStyle(),
        cursorColor: Colors.white,
        controller: controller,
        validator: validator,
      ),
    );
  }

  OutlineInputBorder buildSearchTextInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: AppColors.darkPurple,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  TextStyle textFieldLabelStyle() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      color: Colors.black,
    );
  }
}