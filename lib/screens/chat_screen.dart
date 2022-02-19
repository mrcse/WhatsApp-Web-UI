import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_ui/constants.dart';
import 'package:whatsapp_ui/data/chat_data.dart';
import 'package:whatsapp_ui/model/chat.dart';
import 'package:whatsapp_ui/model/message.dart';
import 'package:whatsapp_ui/provider/chat_provider.dart';
import 'package:whatsapp_ui/widgets/chat_message_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen();
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String friendName;
  String imageUrl;
  List<Message> messagesList;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 500.0);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Chat chat =
        chats[Provider.of<ChatProvider>(context).currentChatIndex];
    friendName = chat.memberTwoName;
    imageUrl = chat.memberTwoProfilePicUrl;
    messagesList = chat.messagesList;

    return _buildChat();
  }

  Container _buildChat() {
    return Container(
      child: Column(
        children: [
          _buildAppBar(context),
          _buildMessagesList(),
          _buildMessageComposer()
        ],
      ),
    );
  }

  Expanded _buildMessagesList() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 24.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: messagesList.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatMessageWidget(messagesList[index]);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: CustomColors.kGreyColor,
      titleSpacing: 0.0,
      title: Row(
        children: [
          SizedBox(
            width: 10.0,
          ),
          CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
            radius: 20,
          ),
          SizedBox(width: 10.0),
          Text(
            friendName,
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
      actions: [
        Icon(
          Icons.video_call,
          color: CustomColors.kIconColor,
        ),
        SizedBox(width: 15.0),
        Icon(
          Icons.call,
          color: CustomColors.kIconColor,
        ),
        SizedBox(width: 15.0),
        Icon(
          Icons.more_vert,
          color: CustomColors.kIconColor,
        ),
      ],
    );
  }

  Widget _buildMessageComposer() {
    final textField = Container(
      decoration: BoxDecoration(
        color: CustomColors.kLightColor,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.0),
          Icon(
            Icons.insert_emoticon,
            color: CustomColors.kIconColor,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Type a message...', border: InputBorder.none),
            ),
          ),
          Icon(
            Icons.attach_file,
            color: CustomColors.kIconColor,
          ),
          Icon(
            Icons.camera_alt,
            color: CustomColors.kIconColor,
          ),
          SizedBox(width: 8.0)
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: textField),
          SizedBox(width: 8.0),
          CircleAvatar(
            child: Icon(Icons.send),
          ),
          SizedBox(width: 24.0),
        ],
      ),
    );
  }
}
