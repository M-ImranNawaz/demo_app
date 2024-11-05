import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key,
      this.controller,
      this.suffix,
      this.hint,
      this.label,
      this.isRequired = true,
      this.isPasswordField,
      this.inputType,
      this.autofillHints,
      this.validator,
      this.bottomSpace,
      this.onChanged,
      this.maxLines = 1,
      this.initialValue,
      this.borderRadius,
      this.focusNode,
      this.onFieldSubmitted,
      this.isDense = true,
      this.style,
      this.padding});
  final BorderRadius? borderRadius;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? hint;
  final String? label;
  final Function(String?)? validator;
  final TextInputType? inputType;
  final Iterable<String>? autofillHints;
  final bool? isPasswordField;
  final bool isRequired;
  final double? bottomSpace;
  final void Function(String)? onChanged;
  final int? maxLines;
  final String? initialValue;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted; // Add this line
  final EdgeInsets? padding;
  final TextStyle? style;
  final bool isDense;
  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool showHidePassword;
  @override
  void initState() {
    if (widget.isPasswordField != null) {
      showHidePassword = widget.isPasswordField!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          style: widget.style,
          obscureText: (widget.isPasswordField != null && showHidePassword),
          onTapOutside: widget.focusNode == null
              ? (event) {
                  FocusScope.of(context).unfocus();
                }
              : null,
          initialValue: widget.initialValue,
          maxLines: widget.maxLines,
          keyboardType: widget.inputType,
          onChanged: widget.onChanged,
          textInputAction: widget.onFieldSubmitted == null
              ? TextInputAction.next
              : TextInputAction.done,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.isRequired
              ? (String? value) {
                  if (value!.isEmpty) {
                    return 'This Field is Required';
                  }
                  if (widget.validator != null) return widget.validator!(value);
                  return null;
                }
              : null,
          decoration: InputDecoration(
            contentPadding: widget.padding,
            border: OutlineInputBorder(
              borderRadius: widget.borderRadius ??
                  const BorderRadius.all(Radius.circular(12.0)),
            ),
            isDense: widget.isDense,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: (widget.isPasswordField != null)
                ? IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        if (!showHidePassword) {
                          showHidePassword = true;
                        } else {
                          showHidePassword = false;
                        }
                      });
                    },
                    icon: Icon(
                      (showHidePassword)
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Theme.of(context).primaryColor,
                    ))
                : widget.suffix,
          ),
        ),
        SizedBox(height: widget.bottomSpace)
      ],
    );
  }
}
