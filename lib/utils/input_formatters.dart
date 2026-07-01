import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class InputFormatters {
  static MaskTextInputFormatter get creditCardNumber => MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static MaskTextInputFormatter get creditCardDate => MaskTextInputFormatter(
    mask: '!#/####',
    filter: {"#": RegExp(r'[0-9]'), "!": RegExp(r'[0-1]')},
    type: MaskAutoCompletionType.lazy,
  );
  static MaskTextInputFormatter get creditCardCvv => MaskTextInputFormatter(
    mask: '###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
