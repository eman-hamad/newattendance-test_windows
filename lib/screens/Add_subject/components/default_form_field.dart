import 'package:flutter/material.dart';

Widget defaultFormField(
        {@required TextEditingController? controller,
        @required TextInputType? type,
        @required String? text,
        Function? onSubmit,
        Function? onChange,
        Function(String)? validate,
        Function? onTap,
        @required IconData? prefix,
        IconData? suffix,
        bool isPassword = false,
        bool isClickable = false,
        Function? suffixpressed,
        FocusNode? focus,
        bool interact = true}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      focusNode: focus,
      enableInteractiveSelection: interact,
      // onTap:tapped ,
      // or obscureText: isPassword ? true: false ,
      // means : isPassword have a value or not
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        // suffixIcon: suffix != null
        // ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
        // : null,
      ),
      // onFieldSubmitted: onSubmit,
      // onChanged: onChange,
      validator: (value) => validate!(value!),
      // onTap: onTap,

      readOnly: isClickable,
    );
