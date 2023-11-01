import 'package:flutter/material.dart';
import 'package:flutter_block/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool isChat;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;

  const CustomTextFormField({
    this.hintText,
    this.errorText,
    this.validator,
    this.keyboardType,
    required this.controller,
    this.obscureText = false,
    this.autofocus = false,
    this.isChat = false,
    required this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: isChat? BorderRadius.circular(30): BorderRadius.circular(5),
      borderSide: BorderSide(
        color: isChat? BODY_TEXT_COLOR :INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: PRIMARY_COLOR,
      autofocus: autofocus,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: 1,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          // borderSide: baseBorder.borderSide.copyWith(
          //   color: PRIMARY_COLOR,
          // ),
          borderSide: BorderSide(color: PRIMARY_COLOR)
        ),
      ),
    );
  }
}
