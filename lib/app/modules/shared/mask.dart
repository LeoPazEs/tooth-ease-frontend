import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Mask {
  final maskData = MaskTextInputFormatter(
    mask: "##/##/#### ##:##",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  final maskTel = MaskTextInputFormatter(
      mask: "####-####", filter: {"#": RegExp(r'[0-9]')});

  final maskCell = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});

  final maskCep = MaskTextInputFormatter(
      mask: "#####-###", filter: {"#": RegExp(r'[0-9]')});
}
