import 'package:flutter/material.dart';
import 'package:hrtodo/utils/app_colors.dart';

class Input extends StatefulWidget {
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
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _obscurePasswordText = true;

  @override
  Widget build(BuildContext context) {
    if (widget.onClick != null) {
      return Stack(
        children: [
          _buildTextFormField(context),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: GestureDetector(
              onTap: () => widget.onClick!.call(),
            ),
          )
        ],
      );
    } else {
      return _buildTextFormField(context);
    }
  }

  Widget _buildTextFormField(context) {
    if (widget.keyboardType == TextInputType.visiblePassword) {
      return TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscurePasswordText,
        readOnly: widget.onClick != null,
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          prefix: widget.prefixIcon != null
              ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  widget.prefixIcon,
                  size: 16,
                ),
              )
              : null,
          prefixIconConstraints: widget.prefixIcon != null
              ? const BoxConstraints(minHeight: 100)
              : null,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscurePasswordText = !_obscurePasswordText;
              });
            },
            icon: Icon(_obscurePasswordText
                ? Icons.visibility_off
                : Icons.visibility,
              color: _obscurePasswordText
                  ? Colors.grey
                  : AppColors.primaryColor,
            ),
          ),
        ),
      );
    } else {
      return TextFormField(
        controller: widget.controller,
        keyboardType: widget.maxLines != null ? TextInputType.multiline : widget.keyboardType,
        maxLines: widget.maxLines,
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
        readOnly: widget.onClick != null,
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          prefix: widget.prefixIcon != null
              ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  widget.prefixIcon,
                  size: 16,
                ),
              )
              : null,
          prefixIconConstraints: widget.prefixIcon != null
              ? const BoxConstraints(minHeight: 100)
              : null,
          suffixIcon: widget.suffixWidget ?? Container(width: 2)
        ),
      );
    }
  }
}
