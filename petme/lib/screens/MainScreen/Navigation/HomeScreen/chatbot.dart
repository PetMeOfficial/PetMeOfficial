import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);


  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  late DialogFlowtter _dialogflow;
  final List<String> _predefinedQuestions = [
    'How do I reset my password?',
    'Teething Process Of Pet ?',
    'How Do I Delete My Pet Profile?',
    'How do I contact customer support?',
  ];
  List<Widget> _messages = [];
  bool _showPredefinedQuestions = true;


  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((value) => _dialogflow = value);
    _messages.add(_buildChatBubble("Hi there! How can I assist you today?"));
  }

  void _togglePredefinedQuestions() {
    setState(() {
      _showPredefinedQuestions = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }


  List<Widget> _buildPredefinedQuestions() {
    return _predefinedQuestions.map((question) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ElevatedButton(
          onPressed: () async {
            final response = await _dialogflow.detectIntent(
                queryInput: QueryInput(text: TextInput(text: question)));
            _displayResponse(response, question);
            _scrollToEnd();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF487776), // change button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              question,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  void _onSend() async {
    final query = _controller.text;
    _controller.clear();
    _displayMessage(query, isUser: true);
    final response = await _dialogflow.detectIntent(
        queryInput: QueryInput(text: TextInput(text: query)));
    _displayMessage(response.text!, isUser: false);
    _scrollToEnd();
    _togglePredefinedQuestions(); // hide predefined questions
    FocusScope.of(context).unfocus();
  }


  void _displayMessage(String message, {bool isUser = false}) {
    setState(() {
      _messages.add(_buildChatBubble(message, isUser: isUser));
    });
  }

  void _displayResponse(DetectIntentResponse response, String query) {
    final botMessage = response.text;
    setState(() {
      _messages.add(_buildChatBubble(query, isUser: true));
      _messages.add(_buildChatBubble(botMessage!, isUser: false));
    });
  }

  Widget _buildChatBubble(String text, {bool isUser = false,}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/bot.jpg'),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isUser ? const Color(0xFF487776) : Colors.grey[200],
              ),
              child: Text(
                text,
                softWrap: true,
              ),
            ),
          ),
          if (isUser)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetMe ChatBot'),
        backgroundColor: const Color(0xFF487776),
        actions: const [],
      ),
      backgroundColor: const Color(0xFFF5F5DC),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ..._messages,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message here',
                    ),
                    enableSuggestions: false, // disable suggestions
                  ),

                ),
                IconButton(
                  onPressed: _onSend,
                  icon: const Icon(Icons.send),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showPredefinedQuestions = !_showPredefinedQuestions;
                    });
                  },
                  icon: Icon(
                    _showPredefinedQuestions ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                  ),
                ),


              ],
            ),
          ),
          if (_showPredefinedQuestions)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _buildPredefinedQuestions(),
              ),
            ),
        ],
      ),
    );
  }
}