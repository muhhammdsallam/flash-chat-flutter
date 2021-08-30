import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  MessageBubble({@required this.sender, @required this.text, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? EdgeInsets.only(left: 50, right: 5)
          : EdgeInsets.only(right: 50, left: 5, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
            elevation: 0,
            color: isMe ? Color(0xFF006BFF) : Colors.grey.shade300,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              child: isMe
                  ? Text('$text',
                      style: TextStyle(
                          fontSize: 15,
                          color: isMe ? Colors.white : Colors.black))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sender,
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 12.0),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('$text',
                            style: TextStyle(
                                fontSize: 15,
                                color: isMe ? Colors.white : Colors.black)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
