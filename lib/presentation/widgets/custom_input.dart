import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';

class CustomInput extends StatefulWidget {
  final String? hint;
  final String? title;
  final String? errorMessage;
  final TextInputType? textInputType;
  final Function(String)? onChanged;
  final bool? enable;
  final bool? isPassword;
  final bool? isPin;
  final bool? multLine;
  final int? maxLength;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int maxLines;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Widget? suffix;
  final Widget? outSuffix;
  final Widget? prefix;
  final Function()? onTap;
  final bool? readOnly;
  final String? prefixText;

  const CustomInput({
    super.key,
    this.hint,
    this.title,
    this.errorMessage,
    this.textInputType,
    this.onChanged,
    this.enable = true,
    this.isPassword = false,
    this.isPin = false,
    this.multLine = false,
    this.maxLines = 6,
    this.maxLength,
    this.controller,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.onSubmitted,
    this.focusNode,
    this.fontWeight,
    this.fontSize,
    this.textStyle,
    this.hintTextStyle,
    this.suffix,
    this.outSuffix,
    this.prefix,
    this.onTap,
    this.readOnly,
    this.prefixText,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool obscure;

  @override
  void initState() {
    obscure = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !widget.enable!,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.title != null)
                      Expanded(
                        child: Text(
                          widget.title ?? '',
                          style: AppTextStyles.inputTitle,
                        ),
                      ),
                    if (widget.maxLength != null)
                      Text(
                        '${widget.controller?.text.length ?? '0'}/${widget.maxLength}',
                        style: AppTextStyles.inputTitle,
                      ),
                  ],
                ),
                TextFormField(
                  key: widget.key,
                  onTap: widget.onTap,
                  maxLines: widget.multLine! ? widget.maxLines : 1,
                  focusNode: widget.focusNode,
                  textCapitalization: widget.textCapitalization!,
                  inputFormatters: widget.inputFormatters,
                  controller: widget.controller,
                  autofocus: widget.autofocus!,
                  readOnly: !widget.enable! || (widget.readOnly ?? false),
                  obscuringCharacter: '•',
                  onFieldSubmitted: widget.onSubmitted,
                  maxLength: widget.isPin! ? 6 : widget.maxLength,
                  validator: (value) {
                    return widget.errorMessage;
                  },
                  style:
                      widget.textStyle ??
                      AppTextStyles.inputTitle.copyWith(
                        fontSize: widget.fontSize,
                        letterSpacing:
                            widget.isPassword!
                                ? 4
                                : widget.isPin!
                                ? 24
                                : null,
                        fontWeight: widget.fontWeight,
                      ),
                  keyboardType: widget.textInputType,
                  onChanged: widget.onChanged,
                  obscureText: widget.isPassword! && obscure,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: widget.prefix,
                    prefixText: widget.prefixText,
                    counter: const SizedBox(),
                    suffixIcon:
                        widget.isPassword!
                            ? obscure
                                ? IconButton(
                                  icon: Icon(
                                    CustomIcons.eye_2_fill,
                                    color: AppColors.text,
                                  ),
                                  onPressed:
                                      () => setState(() {
                                        obscure = !obscure;
                                      }),
                                )
                                : IconButton(
                                  icon: Icon(
                                    CustomIcons.eye_close_line,
                                    color: AppColors.text,
                                  ),
                                  onPressed:
                                      () => setState(() {
                                        obscure = !obscure;
                                      }),
                                )
                            : widget.suffix,
                    hintText: widget.isPin! ? "000000" : widget.hint,
                    hintStyle:
                        widget.hintTextStyle ??
                        AppTextStyles.inputTitle.copyWith(
                          fontSize: widget.fontSize,
                          letterSpacing: widget.isPin! ? 24 : null,
                          fontWeight: widget.fontWeight,
                          color: AppColors.disable,
                        ),
                    prefixStyle:
                        widget.textStyle ??
                        AppTextStyles.inputTitle.copyWith(
                          fontSize: widget.fontSize,
                          letterSpacing:
                              widget.isPassword!
                                  ? 4
                                  : widget.isPin!
                                  ? 24
                                  : null,
                          fontWeight: widget.fontWeight,
                        ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.disable,
                        width: 1.0,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: AppColors.disable,
                        width: 1.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                if (widget.errorMessage != null)
                  Text(
                    widget.errorMessage ?? '',
                    style: AppTextStyles.inputTitle.copyWith(
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
          ),
          if (widget.outSuffix != null) widget.outSuffix ?? const SizedBox(),
        ],
      ),
    );
  }
}
