import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile().then((value) => _dialogflow = value);
    _messages.add(_buildChatBubble("Hi there! How can I assist you today?"));
  }

  final _controller = TextEditingController();
  late DialogFlowtter _dialogflow;
  //final _dialogflow = Dialogflowter.fromFile('path/to/dialog_flow_auth.json');
  List<String> _predefinedQuestions = [
    'How do I reset my password?',
    'How do I update my profile information?',
    'How do I delete my account?',
    'How do I contact customer support?',
  ];

  List<Widget> _buildPredefinedQuestions() {
    return _predefinedQuestions
        .map((question) => ElevatedButton(
      onPressed: () async {
        final response = await _dialogflow.detectIntent(queryInput: QueryInput(text: TextInput(text: question)));
        _displayResponse(response,question);
      },
      child: Text(question),
    ))
        .toList();
  }

  void _onSend() async {
    final query = _controller.text;
    _controller.clear();
    _displayMessage(query, isUser: true);
    final response = await _dialogflow.detectIntent(queryInput: QueryInput(text: TextInput(text: query)));
    _displayMessage(response.text!, isUser: false);
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


  Widget _buildChatBubble(String text, {bool isUser = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isUser ? Colors.deepPurple[300] : Colors.grey[200],
        ),
        child: Text(text),
      ),
    );
  }

  List<Widget> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('PetMe ChatBot'),
          backgroundColor: Colors.deepPurple[300],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ..._messages,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message here',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _onSend,
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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