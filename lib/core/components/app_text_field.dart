import 'package:pos_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_text.dart';

final _borderStyle = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(width: 1, color: AppColor.neutral[200]!),
);

const _onFocusedBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: AppColor.primary),
);

const _onFocusedUnderlineBorder = UnderlineInputBorder(
  borderSide: BorderSide(width: 1, color: AppColor.primary),
);

const _roundedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(30)),
  borderSide: BorderSide(width: 0, color: Color(0xffE5E5E5)),
);

const _noneBorder = InputBorder.none;

enum TextFieldBorderStyle { fullBorder, underlineBorder, roundedBorder, none }

enum TextFieldAlign { left, center, right }

enum ContentPadding {
  all16,
  horizontal16,
  vertical16,
  all8,
  horizontal8,
  vertical8,
  all0,
}

class AppValidatorTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final int maxLength;
  final bool isSetLength;
  final TextInputType? inputType;
  final String? initialText;
  final bool isObscure;
  final TextFieldAlign textAlign;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffixWidget;
  final BoxConstraints? suffixConstraints;
  final EdgeInsetsGeometry? margin;
  final TextFieldBorderStyle textFieldBorderStyle;
  final bool readOnly;
  final String? suffixText;
  final String? prefixText;
  final int? decimalDigit;
  final ContentPadding? contentPadding;
  final int maxLines;
  final Widget? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  final Color? fillColor;
  final Color? textColor;
  final bool withUpperLabel;
  final bool isMandatory;
  final String? regexFormater;
  final Function()? onTap;
  final FocusNode? focusNode;
  final String? labelHintText;
  final TextStyle? overrideErrorStyle;
  final AutovalidateMode? autoValidateMode;
  final Widget? prefixWidget;
  final List<TextInputFormatter>? inputFormatters;

  const AppValidatorTextField({
    super.key,
    this.hintText = "",
    this.onSaved,
    this.controller,
    this.labelText,
    this.maxLength = 36,
    this.isSetLength = false,
    this.inputType = TextInputType.text,
    this.initialText,
    this.isObscure = false,
    this.textAlign = TextFieldAlign.left,
    this.onChanged,
    this.validator,
    this.suffixWidget,
    this.suffixConstraints,
    this.margin,
    this.textFieldBorderStyle = TextFieldBorderStyle.fullBorder,
    this.readOnly = false,
    this.suffixText,
    this.prefixText,
    this.decimalDigit,
    this.contentPadding = ContentPadding.horizontal16,
    this.maxLines = 1,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.fillColor = Colors.white,
    this.textColor = Colors.black,
    this.withUpperLabel = true,
    this.isMandatory = false,
    this.regexFormater,
    this.onTap,
    this.focusNode,
    this.labelHintText,
    this.overrideErrorStyle,
    this.autoValidateMode,
    this.prefixWidget,
    this.inputFormatters,
  });

  // listInputType
  // 0 : text
  // 1 : multiline
  // 2 : number
  // 3 : phone
  // 4 : datetime
  // 5 : emailAddress
  // 6 : url
  // 7 : visiblePassword
  // 8 : name
  // 9 : streetAddress
  // 10 : none

  List<TextInputFormatter> get _inputFormatters {
    List<TextInputFormatter> formatters = <TextInputFormatter>[];
    switch (inputType?.index) {
      case 2:
        formatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      case 6:
        formatters.add(FilteringTextInputFormatter.allow(RegExp(" ")));
        break;
      case 9:
        break;
    }
    if (inputFormatters != null) {
      formatters.addAll(inputFormatters!);
    }

    return formatters;
  }

  InputBorder get _borderFormaterOnEnable {
    switch (textFieldBorderStyle) {
      case TextFieldBorderStyle.fullBorder:
        return _borderStyle;
      case TextFieldBorderStyle.underlineBorder:
        return _onFocusedUnderlineBorder;
      case TextFieldBorderStyle.roundedBorder:
        return _roundedBorder;
      case TextFieldBorderStyle.none:
        return _noneBorder;
      default:
        return _borderStyle;
    }
  }

  InputBorder get _borderFormaterOnFocused {
    switch (textFieldBorderStyle) {
      case TextFieldBorderStyle.fullBorder:
        return _onFocusedBorderStyle;
      case TextFieldBorderStyle.underlineBorder:
        return _onFocusedUnderlineBorder;
      case TextFieldBorderStyle.roundedBorder:
        return _roundedBorder;
      case TextFieldBorderStyle.none:
        return _noneBorder;
      default:
        return _onFocusedBorderStyle;
    }
  }

  TextAlign get _textAlign {
    switch (textAlign) {
      case TextFieldAlign.left:
        return TextAlign.start;
      case TextFieldAlign.right:
        return TextAlign.end;
      case TextFieldAlign.center:
        return TextAlign.center;
      default:
        return TextAlign.start;
    }
  }

  EdgeInsetsGeometry get getContentPadding {
    switch (contentPadding) {
      case ContentPadding.all16:
        return const EdgeInsets.all(16);
      case ContentPadding.horizontal16:
        return const EdgeInsets.symmetric(horizontal: 16);
      case ContentPadding.vertical16:
        return const EdgeInsets.symmetric(vertical: 16);
      case ContentPadding.all8:
        return const EdgeInsets.all(8);
      case ContentPadding.horizontal8:
        return const EdgeInsets.symmetric(horizontal: 8);
      case ContentPadding.vertical8:
        return const EdgeInsets.symmetric(vertical: 8);
      case ContentPadding.all0:
        return const EdgeInsets.all(0);
      default:
        return const EdgeInsets.all(16);
    }
  }

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Silahkan isi data';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withUpperLabel)
          Wrap(
            children: [
              Text(labelText ?? "Unknown"),
              // if (labelHintText != null) AppAbuSmallText(labelHintText!),
              if (isMandatory) const Text(" *"),
              const SizedBox(height: 24.0),
            ],
          ),
        TextFormField(
          onTap: onTap,
          autovalidateMode: autoValidateMode,
          inputFormatters: _inputFormatters,
          readOnly: readOnly,
          controller: controller,
          onChanged: onChanged ?? (value) {},
          textAlign: _textAlign,
          cursorColor: AppColor.primary,
          initialValue: initialText,
          keyboardType: inputType,
          obscureText: isObscure,
          maxLines: isObscure ? 1 : maxLines,
          style: TextStyle(
            fontFamily: AppTextStyle.defaultFontFamily,
            color: textColor,
          ),
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            focusColor: AppColor.primary,
            filled: true,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFFA3A3A3), fontSize: 14),
            labelText:
                textFieldBorderStyle == TextFieldBorderStyle.fullBorder
                    ? withUpperLabel
                        ? null
                        : labelText
                    : null,
            labelStyle: TextStyle(color: AppColor.neutral[400], fontSize: 14),
            errorMaxLines: 2,
            enabledBorder: _borderFormaterOnEnable,
            border: _borderFormaterOnEnable,
            focusedBorder: _borderFormaterOnFocused,
            contentPadding: getContentPadding,
            suffixText: suffixText,
            prefixText: prefixText,
            suffixIcon: suffixWidget,
            suffixIconConstraints: suffixConstraints,
            suffixIconColor: AppColor.primary,
            prefixIcon: prefixIcon,
            errorStyle:
                overrideErrorStyle ??
                const TextStyle(color: Colors.red, fontSize: 14),
            counterText: "",
            prefix: prefixWidget,
          ),
          validator: validator ?? defaultValidator,
          onSaved: onSaved ?? (value) {},
          maxLength: isSetLength ? maxLength : null,
          focusNode: focusNode,
        ),
      ],
    );
  }
}

class AppSearchField extends AppValidatorTextField {
  AppSearchField({
    super.key,
    String? hintText,
    super.labelText,
    super.maxLength,
    super.isSetLength,
    super.inputType = null,
    super.initialText,
    super.isObscure,
    super.textAlign,
    super.onSaved,
    super.onChanged,
    super.validator,
    super.suffixWidget,
    super.suffixConstraints,
    super.margin,
    super.textFieldBorderStyle,
    super.readOnly,
    super.suffixText,
    super.prefixText,
    super.decimalDigit,
    ContentPadding? contentPadding,
    super.maxLines,
    Widget? prefixIcon,
    super.onFieldSubmitted,
    Color? fillColor,
    super.textColor = null,
    bool withUpperLabel = true,
    super.isMandatory,
    super.regexFormater,
    super.onTap,
    super.focusNode,
    super.labelHintText,
    super.overrideErrorStyle,
    void Function()? onTapSearch,
    super.controller,
  }) : super(
         hintText: hintText ?? "Cari data disini ...",
         contentPadding: ContentPadding.vertical8,
         prefixIcon: InkWell(
           onTap: onTapSearch,
           child: Icon(Icons.search, size: 18.0, color: AppColor.neutral[500]),
         ),
         fillColor: fillColor ?? AppColor.neutral[200],
         withUpperLabel: false,
       );
}

class AppDropdownTextField extends StatelessWidget {
  final String? labelText;
  final List<String> listItem;
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final String? hint;
  final bool isMandatory;
  final FormFieldValidator<String>? validator;
  final Function()? onTap;
  final bool isActive;
  final Key? myKey;
  final FocusNode? focusNode;

  const AppDropdownTextField(
    this.labelText,
    this.listItem,
    this.controller, {
    this.onChanged,
    this.hint,
    this.isMandatory = false,
    this.validator,
    this.onTap,
    this.isActive = true,
    this.myKey,
    this.focusNode,
    super.key,
  });

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Silahkan isi data';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget? hint() {
      return this.hint != null ? Text(this.hint ?? "Unknown") : null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Wrap(
            children: [
              Text(labelText!),
              if (isMandatory) const Text(" *"),
              const SizedBox(height: 24.0),
            ],
          ),
        if (labelText != null) const SizedBox(height: 3),
        controller.text.isNotEmpty
            ? DropdownButtonFormField(
              key: myKey,
              isExpanded: true,
              onTap: onTap,
              focusNode: focusNode,
              padding: const EdgeInsets.all(0),
              validator: validator ?? defaultValidator,
              style: const TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                border: _borderStyle,
                disabledBorder: _borderStyle,
                focusedBorder: _onFocusedBorderStyle,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              dropdownColor: Colors.white,
              items:
                  listItem.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              value: controller.text,
              hint: hint(),
              onChanged:
                  isActive
                      ? (value) {
                        controller.text = value.toString();
                        if (onChanged != null) onChanged!(value.toString());
                      }
                      : null,
            )
            : DropdownButtonFormField(
              key: myKey,
              isExpanded: true,
              onTap: onTap,
              validator: validator ?? defaultValidator,
              padding: const EdgeInsets.all(0),
              style: const TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                border: _borderStyle,
                enabledBorder: _borderStyle,
                focusedBorder: _onFocusedBorderStyle,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              dropdownColor: Colors.white,
              items:
                  listItem.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              hint: hint(),
              onChanged:
                  isActive
                      ? (value) {
                        controller.text = value.toString();
                        if (onChanged != null) onChanged!(value.toString());
                      }
                      : null,
            ),
      ],
    );
  }
}
