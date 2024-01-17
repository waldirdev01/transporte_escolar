import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:transporte_escolar/app/core/ui/theme_extensions.dart';

// ignore: must_be_immutable
class AppField extends StatelessWidget {
  final TextInputAction? textInputAction;
  final String label;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final IconButton? suffixIcon;
  bool? obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final FocusNode? focusNode;
  AppField(
      {super.key,
      required this.label,
      this.controller,
      this.validator,
      this.suffixIcon,
      this.obscureText = false,
      this.focusNode,
      this.textInputAction})
      : assert(obscureText == true ? suffixIcon == null : true,
            'obscureText não pode ser passado em conjunto com suffixIcon'),
        obscureTextVN = ValueNotifier(obscureText!);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: obscureTextVN,
        builder: (_, obscureTextValue, child) {
          return TextFormField(
            textInputAction: textInputAction,
            focusNode: focusNode,
            controller: controller,
            validator: validator,
            obscureText: obscureTextValue,
            decoration: InputDecoration(
              isDense: true,
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.red)),
              suffixIcon: suffixIcon ??
                  (obscureText == true
                      ? IconButton(
                          onPressed: () {
                            obscureTextVN.value = !obscureTextVN.value;
                          },
                          icon: Icon(
                            obscureTextValue
                                ? IconlyBroken.show
                                : IconlyBroken.hide,
                            size: 24,
                            color: context.primaryColor,
                          ),
                        )
                      : null),
            ),
          );
        });
  }
}
