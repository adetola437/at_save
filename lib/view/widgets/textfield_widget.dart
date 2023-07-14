import 'package:at_save/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';

import '../../theme/colors.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String textFieldType;
  Function? setDate;
  TextfieldWidget(
      {required this.controller,
      required this.hintText,
      required this.textFieldType,
      this.setDate,
      super.key});

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.textFieldType == 'date' ? false : true,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidationBuilder().required().build(),
      inputFormatters: widget.textFieldType == 'amount'
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : [],
      keyboardType: widget.textFieldType == 'amount'
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        // suffixIcon: Container(
        //   height: 15,
        //   width: 15,
        //   margin: const EdgeInsets.only(right: 8, top: 5, bottom: 5),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(30),
        //       color: const Color.fromARGB(255, 238, 236, 236)),
        //   child: widget.textFieldType == 'date'
        //       ? IconButton(
        //           onPressed: () {
        //             widget.setDate!();
        //           },
        //           icon: const Icon(
        //             Icons.calendar_month,
        //             color: AppColor.secondaryColor,
        //           ))
        //       : Container(),
        // ),
        hintStyle: MyText.mobileMd(),
        hintText: widget.hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 244, 241, 241),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryText, width: 0)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryText, width: 0)),
        //prefixIcon: Image.asset('assets/email.png')
      ),
    );
  }
}
