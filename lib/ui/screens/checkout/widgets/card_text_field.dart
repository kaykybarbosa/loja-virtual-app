import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class CardTextField extends StatelessWidget {
  const CardTextField({
    super.key,
    this.bold = false,
    required this.title,
    required this.hint,
    this.textInputType,
    this.inputFormatters,
    this.validator,
    this.textAlign,
    this.focusNode,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
  });

  final String title;
  final bool bold;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.base100,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),

                // Erro
                if (title.isNotEmpty && state.hasError)
                  Text(
                    state.errorText!,
                    style: TextStyle(
                      color: AppColors.warn,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),

            // Field
            TextFormField(
              style: TextStyle(
                color: title.isEmpty && state.hasError
                    ? AppColors.warn
                    : AppColors.base100,
                fontWeight: bold ? FontWeight.bold : null,
              ),
              textAlign: textAlign ?? TextAlign.start,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: title.isEmpty && state.hasError
                      ? Colors.red.withAlpha(200)
                      : AppColors.base100.withAlpha(100),
                ),
                isDense: true,
                border: InputBorder.none,
                counterText: '',
                contentPadding: EdgeInsets.symmetric(vertical: 2),
              ),
              cursorColor: AppColors.base100,
              keyboardType: textInputType,
              inputFormatters: inputFormatters,
              focusNode: focusNode,
              onFieldSubmitted: onSubmitted,
              textInputAction: textInputAction,
              onChanged: (value) {
                state.didChange(value);
              },
            ),
          ],
        );
      },
    );
  }
}
