import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_for_health/core/constants/api_constants.dart';
import 'package:food_for_health/core/constants/app_colors.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
//Yapay Zeka İle Sohbet Et Sayfası

class ChatWithAiView extends StatefulWidget {
  const ChatWithAiView({super.key});

  @override
  State<ChatWithAiView> createState() => _ChatWithAiViewState();
}

class _ChatWithAiViewState extends State<ChatWithAiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const ChatWidget(apiKey: ApiConstants.geminiAPIKey),
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    required this.apiKey,
    super.key,
  });

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];
  bool _loading = false;
  bool isInitialView = true;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: widget.apiKey,
    );
    _chat = _model.startChat();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  InputDecoration textFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.all(10),
    hintText: 'Yapay zeka ile sohbet et..',
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.appsMainColor, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.appsMainColor, width: 2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: isInitialView
                ? ChatWithAiInitialView()
                : ApiConstants.geminiAPIKey.isNotEmpty
                    ? ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, idx) {
                          final content = _generatedContent[idx];
                          return MessageWidget(
                            text: content.text,
                            image: content.image,
                            isFromUser: content.fromUser,
                          );
                        },
                        itemCount: _generatedContent.length,
                      )
                    : ListView(
                        children: const [
                          Text(
                            'No API key found. Please provide an API Key using',
                          ),
                        ],
                      ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _textFieldFocus,
                    decoration: textFieldDecoration,
                    controller: _textController,
                  ),
                ),
                const SizedBox.square(dimension: 15),
                if (!_loading)
                  IconButton(
                    onPressed: () async {
                      _sendChatMessage(_textController.text);
                      isInitialView = false;
                    },
                    icon: Icon(
                      Icons.send,
                      color: AppColors.appsMainColor,
                      size: 30,
                    ),
                  )
                else
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      if (e.toString().contains("SocketException")) {
        _showError("İnternet bağlantınızı kontrol ediniz.");
      } else {
        _showError("Bir Hata Oluştu.");
      }

      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class ChatWithAiInitialView extends StatelessWidget {
  const ChatWithAiInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 25,
              children: [
                Icon(FontAwesomeIcons.solidComments, color: AppColors.appsMainColor, size: 80),
                Text("Yapay Zeka İle Sohbet Et!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(
                  "Yapay zeka ile istediğin konuda sohbet edebilirsin!\n\nHastalıklarınla ilgili bilgi alabilir,\nHastalığına dair neleri yemen gerek neleri yememen gerek sorabilir,\ntedavi yöntemleri hakkında bilgiler alabilirsin.\n\nHaydi Başla!👇🏽",
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
                decoration: BoxDecoration(
                  color: isFromUser ? Color(0xFFF4F1F8) : AppColors.appsMainColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                child: Column(children: [
                  if (text case final text?)
                    MarkdownBody(
                      data: text,
                      styleSheet: MarkdownStyleSheet(
                          p: TextStyle(
                        fontSize: 16,
                        color: isFromUser ? Colors.black : Colors.white,
                      )),
                    ),
                  if (image case final image?) image,
                ]))),
      ],
    );
  }
}
