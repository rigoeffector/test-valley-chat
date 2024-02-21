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
        appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF',
        userId: '574621',
        otherUsers: ['1', '2', '3', '4'],
        openChannelUrl:
            'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211',
        apiToken: 'f93b05ff359245af400aa805bafd2a091a173064',
        apiUrl: 'https://api-BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF.sendbird.com',
      ),
    );
  }
}
