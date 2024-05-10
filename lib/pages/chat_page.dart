import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_application/lib.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final AuthServices _authService = AuthServices();
  final ChatService _chatService = ChatService();

  // send message
  Future<void> sendMessage() async {
    // if there is something in the message controller
    if (_messageController.text.isNotEmpty) {
      // send message
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(receiverEmail)),
        body: Column(
          children: [
            // display messages
            Expanded(
              child: _buildMessagesList(),
            ),
            // display message input
            // MessageInput(),
            _buildMessageInput(),
          ],
        ));
  }

  Widget _buildMessagesList() {
    String senderID = _authService.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // loading
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!;
        return ListView(
          reverse: true,
          padding: const EdgeInsets.all(8.0),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: snapshot.data!.docs
              .map((doc) => _buildMessagesItem(doc))
              .toList(),
        );
      },
    );
  }

  // build messages item
  Widget _buildMessagesItem(DocumentSnapshot doc) {
    Map<String, dynamic> message = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = message['senderID'] == _authService.currentUser!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          children: [
            ChatBubble(message: message['message'], isSender: isCurrentUser),
            // Text(message['message']),
          ],
        ));
  }

  // build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        // textField
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(18.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              // border: Border.all(),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade200,
            ),
            child: TextField(
              controller: _messageController,
              obscureText: false,
            ),
          ),
        ),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send)),
      ],
    );
  }
}
