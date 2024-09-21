import 'package:ai_document_app/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_text_style.dart';
import 'color.dart';

class PasswordWidget extends StatefulWidget {
  final Key? fieldKey;
  final int? maxLength;
  final String? hintText;

  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const PasswordWidget({
    Key? key,
    required this.controller,
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.validator,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return textFormField(
        fieldKey: widget.fieldKey,
        hintText: widget.hintText,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        maxLines: 1,
        // prefixIcon: UiInterface.prefixTextFieldIcon(AppAsset.icLock),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            color: hintGreyColor,
          ),
        ),
        validator: widget.validator ??
            (value) => Validators.validateRequired(value!.trim(), 'Password')
        // (value) => Validators.validatePassword(value!.trim()),
        );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.fieldKey,
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.labelText,
    this.validator,
    this.prefixIcon,
    required this.controller,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.borderColor,
    this.filledColor,
    this.enabled,
    this.readonly,
    this.borderRadius,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.scropadding,
    this.textAlign = TextAlign.left,
    this.contentPadding,
  }) : super(key: key);
  final EdgeInsets? scropadding;
  final Key? fieldKey;
  final bool? readonly;
  final String? hintText;
  final String? labelText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? borderColor;
  final Color? filledColor;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onFieldSubmitted;
  final ValueChanged<String?>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final bool? enabled;
  final double? borderRadius;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              labelText ?? "",
              style: AppTextStyle.normalRegular16,
            ),
          ),
        textFormField(
            fieldKey: fieldKey,
            focusNode: focusNode,
            hintText: hintText,
            labelText: labelText,
            // scropadding: scropadding,
            controller: controller,
            // borderRaduis: 10,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            maxLength: maxLength,
            maxLines: maxLines,
            borderRadius: borderRadius,
            enabled: enabled ?? true,
            textInputAction: textInputAction,
            textAlign: textAlign,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            contentPadding: contentPadding,
            textStyle: textStyle,
            hintStyle: hintStyle,
            borderColor: borderColor,
            filledColor: filledColor,
            enabledBorderColor: enabledBorderColor,
            focusedBorderColor: focusedBorderColor,
            errorBorderColor: errorBorderColor),
      ],
    );
  }
}

TextFormField textFormField({
  final Key? fieldKey,
  final String? hintText,
  final String? labelText,
  final String? helperText,
  final String? initialValue,
  final int? errorMaxLines,
  final int? maxLines,
  final int? maxLength,
  final double? borderRadius,
  final bool? enabled,
  final bool autofocus = false,
  final bool obscureText = false,
  final Color? filledColor,
  final Color? cursorColor,
  final Color? borderColor,
  final Color? focusedBorderColor,
  final Color? enabledBorderColor,
  final Color? errorBorderColor,
  final double? borderWidth = 1.0,
  final Widget? prefixIcon,
  final Widget? suffixIcon,
  final FocusNode? focusNode,
  final TextStyle? style,
  final TextStyle? textStyle,
  final TextStyle? hintStyle,
  final TextAlign textAlign = TextAlign.left,
  final TextEditingController? controller,
  final List<TextInputFormatter>? inputFormatters,
  final TextInputAction? textInputAction,
  final TextInputType? keyboardType,
  final TextCapitalization textCapitalization = TextCapitalization.none,
  final GestureTapCallback? onTap,
  final FormFieldSetter<String?>? onSaved,
  final FormFieldValidator<String?>? validator,
  final ValueChanged<String?>? onChanged,
  final ValueChanged<String?>? onFieldSubmitted,
  final EdgeInsetsGeometry? contentPadding,
  final bool? readonly,
  final EdgeInsets? scrollPadding,
}) {
  return TextFormField(
    scrollPadding: scrollPadding ?? EdgeInsets.zero,
    key: fieldKey,
    readOnly: readonly ?? false,
    controller: controller,
    focusNode: focusNode,
    maxLines: maxLines,
    initialValue: initialValue,
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    obscureText: obscureText,
    enabled: enabled,
    validator: validator,
    maxLength: maxLength,
    textInputAction: textInputAction,
    inputFormatters: inputFormatters,
    onTap: onTap,
    onSaved: onSaved,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    autocorrect: true,
    autofocus: autofocus,
    textAlign: textAlign,
    cursorColor: cursorColor ?? primaryWhite,
    cursorHeight: 20,
    style: textStyle ?? AppTextStyle.normalRegular16,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        borderSide: BorderSide(
          color: errorBorderColor ?? borderColor ?? Colors.red,
          width: borderWidth!,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        borderSide: BorderSide(
          color: focusedBorderColor ?? borderColor ?? hintGreyColor,
          width: borderWidth,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        borderSide: BorderSide(
          color: enabledBorderColor ?? borderColor ?? hintGreyColor,
          width: borderWidth,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        borderSide: BorderSide(
          color: borderColor ?? hintGreyColor,
          width: borderWidth,
        ),
      ),
      errorMaxLines: errorMaxLines ?? 5,
      fillColor: filledColor ?? Colors.transparent,
      filled: true,
      hintStyle: hintStyle ??
          AppTextStyle.normalRegular14.copyWith(color: hintGreyColor),
      hintText: hintText ?? "Search your hear",
      enabled: enabled ?? true,
      suffixIcon: suffixIcon,
      // labelText: labelText,
      helperText: helperText,
    ),
  );
}
