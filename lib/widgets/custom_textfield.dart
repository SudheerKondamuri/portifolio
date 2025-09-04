import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "(sudheer@kali)-[~] \$",
            style: GoogleFonts.ubuntuMono(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              controller: widget.controller,
              onSubmitted: widget.onSubmitted,
              cursorColor: Colors.white,
              cursorHeight: 18,
              cursorWidth: 10,
              autofocus: true,
              style: GoogleFonts.ubuntuMono(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
