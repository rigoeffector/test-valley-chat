import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChatScreen extends StatefulWidget {
  final String appId;
  final String userId;
  final List<String> otherUsers;
  final String openChannelUrl;
  final String apiToken;
  final String apiUrl;

  ChatScreen({
    Key? key,
    required this.appId,
    required this.userId,
    required this.otherUsers,
    required this.openChannelUrl,
    required this.apiToken,
    required this.apiUrl,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ChannelEventHandler {
  List<BaseMessage> _messages = [];
  GroupChannel? _channel;

  @override
  void initState() {
    load();
    super.initState();
  }

  void sendMessage(String text) async {
    try {
      if (_channel != null) {
        _channel!.sendUserMessage(UserMessageParams(message: text));
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void load() async {
    try {
      final sendbird = SendbirdSdk(appId: widget.appId);
      final _ = await sendbird.connect(widget.userId);
      print('Sawa');

      final query = GroupChannelListQuery()
        ..limit = 1
        ..userIdsExactlyIn = widget.otherUsers;
      List<GroupChannel> channels = await query.loadNext();
      GroupChannel aChannel;
      if (channels.isEmpty) {
        aChannel = await GroupChannel.createChannel(GroupChannelParams()
          ..userIds = widget.otherUsers + [widget.userId]);
      } else {
        aChannel = channels[0];
      }

      List<BaseMessage> messages = await aChannel.getMessagesByTimestamp(
          DateTime.now().microsecondsSinceEpoch * 1000, MessageListParams());
      setState(() {
        _messages = messages;
        _channel = aChannel;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0E0D0D'),
      appBar: AppBar(
        backgroundColor: HexColor('#0E0D0D'),
        elevation: 0.1,
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text('강남스팟'),
      ),
      body: _channel != null
          ? DashChat(
              inputCursorColor: Colors.grey,
              inputTextStyle: const TextStyle(color: Colors.white),
              inputContainerStyle: BoxDecoration(color: HexColor('#131313')),
              inputDecoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.0),
                ),
              ),
              messages: _messages.map(asDashChatMessage).toList(),
              user: asDashChatUser(SendbirdSdk().currentUser),
              onSend: onSend,
            )
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            )),
    );
  }

  ChatUser asDashChatUser(User? user) {
    if (user == null) {
      return ChatUser(uid: '', name: '', avatar: '');
    }
    return ChatUser(
      uid: user.userId,
      name: user.nickname,
      avatar: user.profileUrl,
    );
  }

  ChatMessage asDashChatMessage(BaseMessage message) {
    return ChatMessage(
      text: message is UserMessage ? message.message : '',
      user: asDashChatUser(message.sender),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        message.createdAt,
      ),
    );
  }

  void onSend(ChatMessage newMessage) async {
    try {
      sendMessage(newMessage.text!);
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
