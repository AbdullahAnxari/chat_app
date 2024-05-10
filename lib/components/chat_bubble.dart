// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../lib.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: isSender
                ? const TextStyle(color: Colors.white)
                : const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
