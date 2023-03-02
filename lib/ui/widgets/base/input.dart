import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType keyboardType;
  final Widget? suffixWidget;
  final IconData? prefixIcon;
  final VoidCallback? onClick;
  final int? maxLines;
  final TextCapitalization? textCapitalization;

  const Input({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.onClick,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixWidget,
    this.maxLines,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    if (onClick != null) {
      return Stack(
        children: [
          _buildTextFormField(context),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: GestureDetector(
              onTap: () => onClick!.call(),
            ),
          )
        ],
      );
    } else {
      return _buildTextFormField(context);
    }
  }

  Widget _buildTextFormField(context) {
    return TextFormField(
      controller: controller,
      keyboardType: maxLines != null ? TextInputType.multiline : keyboardType,
      maxLines: maxLines,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      readOnly: onClick != null,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        prefix: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  prefixIcon,
                  size: 16,
                ),
              )
            : null,
        prefixIconConstraints: prefixIcon != null
            ? const BoxConstraints(minHeight: 100)
            : null,
        suffixIcon: suffixWidget ?? Container(width: 2)
      ),
    );
  }
}
