import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portifolio/widgets/custom_textfield.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class TerminalLine {
  final String text;
  final bool isCommand;
  final bool isActiveField;
  final TextEditingController? controller;

  TerminalLine({
    required this.text,
    this.isCommand = false,
    this.isActiveField = false,
    this.controller,
  });
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late VideoPlayerController _videoController;

  List<TerminalLine> lines = [];
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
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset("assets/videos/blackhole.mp4")
          ..initialize().then((_) {
            _videoController.setLooping(true);
            _videoController.play();
            setState(() {});
          });

    lines.add(TerminalLine(text: "Welcome to Sudheer's Terminal"));
    lines.add(TerminalLine(text: asciiText));
    lines.add(TerminalLine(text: "Type 'help' for assistance"));
    lines.add(
      TerminalLine(
        text: "",
        isActiveField: true,
        controller: TextEditingController(),
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _handleSubmit(int index, String value) {
    setState(() {
      final line = lines[index];
      lines[index] = TerminalLine(text: value, isCommand: true);

      String output = _getCommandOutput(value);

      if (output.isNotEmpty) {
        lines.add(TerminalLine(text: output));
      }

      if (value.toLowerCase() != 'clear') {
        lines.add(
          TerminalLine(
            text: "",
            isActiveField: true,
            controller: TextEditingController(),
          ),
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  String _getCommandOutput(String command) {
    switch (command.toLowerCase()) {
      case 'help':
        return '''
          Available commands:
          help      - Show this help message
          aboutme   - About me
          skills    - My skills
          projects  - My projects
          clear     - Clear the terminal

''';
      case 'aboutme':
        return '''
        Hey I'm Sudheer Kondamuri, a passionate tech enthusiast exploring the realms of cybersecurity and software development.
        I love building creative apps, especially those that combine security, design, and interactivity.
        Currently, I’m deep-diving into Flutter to craft immersive mobile experiences.
        I enjoy solving challenges, learning new technologies, and pushing the limits of what apps can do.
        When I’m not coding, you’ll find me exploring cybersecurity concepts, gaming, or binge-watching tech shows.
        I aim to create projects that are not just functional but also visually engaging and secure.
''';
      case 'skills':
        return "Flutter, Dart, Cybersecurity, Linux, Web3";
      case 'projects':
        return "Check my GitHub: https://github.com/sudheer";
      case 'clear':
        setState(() {
          lines = [
            TerminalLine(text: "Welcome to Sudheer's Terminal"),
            TerminalLine(text: asciiText),
            TerminalLine(text: "Type 'help' for assistance"),
            TerminalLine(
              text: "",
              isActiveField: true,
              controller: TextEditingController(),
            ),
          ];
        });
        return "";
      default:
        return "Command not found. Type 'help' for assistance.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // VIDEO BACKGROUND
          Positioned.fill(
            child: _videoController.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  )
                : Container(color: Colors.black),
          ),

          // TERMINAL OVERLAY
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
                    boxShadow: const [
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
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 0.8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.new_label, color: Colors.white),
                            SelectableText(
                              'sudheer@kali',
                              style: GoogleFonts.ubuntuMono(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.close_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: lines.length,
                            itemBuilder: (context, index) {
                              final line = lines[index];
                              if (line.isActiveField) {
                                return CustomTextfield(
                                  controller: line.controller!,
                                  onSubmitted: (value) =>
                                      _handleSubmit(index, value),
                                );
                              } else if (line.isCommand) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    "(sudheer@kali)-[~] \$ ${line.text}",
                                    style: GoogleFonts.ubuntuMono(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    line.text,
                                    style: GoogleFonts.ubuntuMono(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }
                            },
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
