import 'package:flutter/material.dart';
import 'package:test_chat/UI/chat.ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData _buildTheme(brightness) {
      var baseTheme = ThemeData(brightness: brightness);

      return baseTheme.copyWith(
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
        ),
        // useMaterial3: true,
        // dividerColor: mTextColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(0x00BFA6, {
            50: Color(0x00BFA6),
            100: Color(0x00BFA6),
            200: Color(0x00BFA6),
            300: Color(0x00BFA6),
            400: Color(0x00BFA6),
            500: Color(0x00BFA6),
            600: Color(0x00BFA6),
            700: Color(0x00BFA6),
            800: Color(0x00BFA6),
            900: Color(0x00BFA6),
          }),
          brightness: brightness,
        ),
        // textTheme: GoogleFonts.nunitoSansTextTheme(baseTheme.textTheme),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: _buildTheme(Brightness.dark),
      home: ChatScreen(
        appId: '7FC4460A-B5B2-44F1-AEC1-3B0F3CE8A727',
        userId: 'sendbird_desk_agent_id_3567144f-6469-474d-903a-e8c36076d40d',
        otherUsers: ['1', '2', '3', '4'],
        openChannelUrl:
            'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211',
        apiToken: '9997a3ce8aa240846cc48fc63fd18ad94d5c16d4',
        apiUrl: 'https://api-7FC4460A-B5B2-44F1-AEC1-3B0F3CE8A727.sendbird.com',
      ),
    );
  }
}
