import 'package:flutter/material.dart';

Widget defaultFormField({

  @required TextEditingController? controller,
  @required TextInputType? type,
   String? text,
  Function? onSubmit,
  Function? onChange,
  @required Function? validate,
  Function? onTap,
  @required IconData? prefix,
  IconData? suffix,
  bool isPassword = false,
  bool isClickable = false,
  Function? suffixpressed,
  FocusNode? focus ,
  bool interact =true
}) =>
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
      // validator: validate,
      // onTap: onTap,

      readOnly: isClickable,
    );