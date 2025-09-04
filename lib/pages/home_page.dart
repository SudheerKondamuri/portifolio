import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String asciiText = '''
  █████████                 █████ █████                                 
 ███░░░░░███               ░░███ ░░███                                  
░███    ░░░  █████ ████  ███████  ░███████    ██████   ██████  ████████ 
░░█████████ ░░███ ░███  ███░░███  ░███░░███  ███░░███ ███░░███░░███░░███
 ░░░░░░░░███ ░███ ░███ ░███ ░███  ░███ ░███ ░███████ ░███████  ░███ ░░░ 
 ███    ░███ ░███ ░███ ░███ ░███  ░███ ░███ ░███░░░  ░███░░░   ░███     
░░█████████  ░░████████░░████████ ████ █████░░██████ ░░██████  █████    
 ░░░░░░░░░    ░░░░░░░░  ░░░░░░░░ ░░░░ ░░░░░  ░░░░░░   ░░░░░░  ░░░░░                                                                       
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/scenery.png", fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white, width: 0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(31, 38, 135, 0.1),
                        blurRadius: 32,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 0.8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.new_label, color: Colors.white),
                            Text(
                              'sudheer@kali',
                              style: GoogleFonts.ubuntuMono(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Icon(Icons.new_label, color: Colors.white),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            child: Text(
                              asciiText,
                              style: GoogleFonts.ubuntuMono(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
