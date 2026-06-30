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
  });

  final String title;
  final bool bold;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

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
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.base100,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),

                // Erro
                if (state.hasError)
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
                color: AppColors.base100,
                fontWeight: bold ? FontWeight.bold : null,
              ),
              decoration: InputDecoration(
                hintText: hint,
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 2),
              ),
              keyboardType: textInputType,
              inputFormatters: inputFormatters,
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
