import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  final controller;
  final hinttext;
  final Icon icon;
  const SearchTextfield(
      {Key? key, this.controller, this.hinttext, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hinttext,
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)))),
      controller: controller,
    );
  }
}
