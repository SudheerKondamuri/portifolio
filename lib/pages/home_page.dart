import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portifolio/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class TerminalLine {
  final String? text;
  final Widget? widget;
  final bool isCommand;
  final bool isActiveField;
  final TextEditingController? controller;

  TerminalLine({
    this.text,
    this.widget,
    this.isCommand = false,
    this.isActiveField = false,
    this.controller,
  });
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

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
    lines.add(TerminalLine(text: "Welcome to Sudheer's Terminal\n"));
    lines.add(TerminalLine(widget: _asciiBanner()));
    lines.add(TerminalLine(text: "Type 'help' for assistance"));
    lines.add(
      TerminalLine(
        text: "",
        isActiveField: true,
        controller: TextEditingController(),
      ),
    );
  }

  void _handleSubmit(int index, String value) {
    setState(() {
      final line = lines[index];
      lines[index] = TerminalLine(text: value, isCommand: true);

      Widget output = _getCommandOutput(value);

      if (output is! SelectableText ||
          (output is SelectableText && output.data!.isNotEmpty)) {
        lines.add(TerminalLine(widget: output));
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

  Widget _asciiBanner() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SelectableText(
        asciiText,
        style: GoogleFonts.ubuntuMono(fontSize: 14, color: Colors.white),
        toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
      ),
    );
  }

  Widget _getCommandOutput(String command) {
    switch (command.toLowerCase()) {
      case 'help':
        return SelectableText(
          '''
Available commands:
help      - Show this help message
aboutme   - About me
skills    - My skills
contact   - Contact me
projects  - My projects
resume    - Download my resume
clear     - Clear the terminal
''',
          style: GoogleFonts.ubuntuMono(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        );
      case 'aboutme':
        return SelectableText(
          '''
Hey I'm Sudheer Kondamuri, a passionate tech enthusiast exploring the realms of cybersecurity and software development.
I love building creative apps, especially those that combine security, design, and interactivity.
Currently, I’m deep-diving into Flutter to craft immersive mobile experiences.
I enjoy solving challenges, learning new technologies, and pushing the limits of what apps can do.
When I’m not coding, you’ll find me exploring cybersecurity concepts, gaming, or binge-watching tech shows.
I aim to create projects that are not just functional but also visually engaging and secure.
''',
          style: GoogleFonts.ubuntuMono(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        );
      case 'skills':
        return SelectableText(
          "Flutter, Dart, Cybersecurity, Linux, Web3",
          style: GoogleFonts.ubuntuMono(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        );
      case 'resume':
        return InkWell(
          onTap: () async {
            final Uri url = Uri.parse(
              "https://drive.google.com/file/d/17sjSU_sRBZCIcHquqqIP2t--z0Wbt914/view",
            );
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.platformDefault);
            }
          },
          child: Text(
            "📄 Download Resume",
            style: GoogleFonts.ubuntuMono(
              color: Colors.lightBlueAccent,
              fontSize: 16,
              decoration: TextDecoration.underline, // underline like a link
            ),
          ),
        );
      case 'contact':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SelectableText(
                  "Email   -> ",
                  style: GoogleFonts.ubuntuMono(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => launchUrl(
                    Uri.parse("mailto:sudheer.kondamuri@gmail.com"),
                  ),
                  child: Text(
                    "sudheer.kondamuri@gmail.com",
                    style: GoogleFonts.ubuntuMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.lightBlueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SelectableText(
                  "GitHub  -> ",
                  style: GoogleFonts.ubuntuMono(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => launchUrl(
                    Uri.parse("https://github.com/SudheerKondamuri"),
                  ),
                  child: Text(
                    "github.com/SudheerKondamuri",
                    style: GoogleFonts.ubuntuMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.lightBlueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SelectableText(
                  "LinkedIn -> ",
                  style: GoogleFonts.ubuntuMono(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => launchUrl(
                    Uri.parse("https://linkedin.com/in/sudheerkondamuri"),
                  ),
                  child: Text(
                    "linkedin.com/in/sudheerkondamuri",
                    style: GoogleFonts.ubuntuMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.lightBlueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SelectableText(
                  "Twitter -> ",
                  style: GoogleFonts.ubuntuMono(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => launchUrl(Uri.parse("https://x.com/sudheer")),
                  child: Text(
                    "x.com/sudheer",
                    style: GoogleFonts.ubuntuMono(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.lightBlueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );

      case 'projects':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _projectBlock(
              title: "HashChat (Web3 + UPI dApp)",
              url: "https://github.com/SudheerKondamuri/HashChat",
              description:
                  "A decentralized chat + UPI dApp combining Web2 and Web3.",
              stack: ["Flutter", "WalletConnect", "XMTP/Matrix", "Firebase"],
            ),
            const SizedBox(height: 16),
            _projectBlock(
              title: "Kube - Crypto + Stock Tracker",
              url: "https://github.com/SudheerKondamuri/Kube",
              description:
                  "A finance tracker for crypto, UPI, and stocks in one app.",
              stack: ["Flutter", "WalletConnect v2", "Finnhub API", "Covalent"],
            ),
            const SizedBox(height: 16),
            _projectBlock(
              title: "FlutterMart - Online Store UI",
              url: "https://github.com/SudheerKondamuri/FlutterMart",
              description:
                  "A multi-screen Flutter store app showcasing navigation, responsive layouts, and product browsing.",
              stack: ["Flutter", "Dart", "Firebase Hosting"],
            ),
            const SizedBox(height: 16),
            _projectBlock(
              title: "WhispPulse - AI Trend & News Tracker",
              url: "https://github.com/SudheerKondamuri/WhispPulse",
              description:
                  "An AI-powered mobile app that scrapes & analyzes real-time news, Reddit, Discord, and X trends with NLP-based summaries and alerts.",
              stack: [
                "Flutter",
                "Node.js",
                "Python (NLP)",
                "Firebase",
                "Web Scraping",
              ],
            ),
          ],
        );

      case 'banner':
        return _asciiBanner();
      case 'clear':
        setState(() {
          lines = [
            TerminalLine(text: "Welcome to Sudheer's Terminal"),
            TerminalLine(widget: _asciiBanner()),
            TerminalLine(text: "Type 'help' for assistance"),
            TerminalLine(
              text: "",
              isActiveField: true,
              controller: TextEditingController(),
            ),
          ];
        });
        return const SizedBox.shrink();
      default:
        return SelectableText(
          "Command not found. Type 'help' for assistance.",
          style: GoogleFonts.ubuntuMono(color: Colors.white),
        );
    }
  }

  Widget _projectBlock({
    required String title,
    required String url,
    required String description,
    required List<String> stack,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => launchUrl(Uri.parse(url)),
          child: Text(
            title,
            style: GoogleFonts.ubuntuMono(
              color: Colors.lightBlueAccent,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SelectableText(
          "$description\nBuilt With:\n- ${stack.join("\n- ")}",
          style: GoogleFonts.ubuntuMono(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/guts.jpg", fit: BoxFit.cover),
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
                            const Icon(Icons.terminal, color: Colors.white),
                            SelectableText(
                              'sudheer@kali',
                              style: GoogleFonts.ubuntuMono(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(Icons.close, color: Colors.white),
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
                                  child: SelectableText(
                                    "(sudheer@kali)-[~] \$ ${line.text}",
                                    style: GoogleFonts.ubuntuMono(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              } else if (line.widget != null) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: line.widget!,
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: SelectableText(
                                    line.text ?? "",
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
