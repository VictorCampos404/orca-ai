import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  Masks();

  static final phoneMask = MaskTextInputFormatter(
    mask: '+55 (##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final fixPhoneMask = MaskTextInputFormatter(
    mask: '+55 (##) ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final ifoodCodeMask = MaskTextInputFormatter(
    mask: '####-####',
    filter: {"#": RegExp(r'[a-zA-Z0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
