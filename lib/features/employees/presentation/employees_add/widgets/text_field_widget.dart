import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.words,
    this.textInputFormatters,
    this.maxLenght,
  }) : super(key: key);
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String label;
  final String? Function(String? str)? validator;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final void Function()? onTap;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? textInputFormatters;
  final int? maxLenght;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      inputFormatters: textInputFormatters,
      maxLength: maxLenght,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: validator,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
