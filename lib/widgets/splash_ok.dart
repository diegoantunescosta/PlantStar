import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantstar/responsive/mobile_screen_layout.dart';
import 'package:plantstar/screens/feed_screen.dart';
import 'package:plantstar/utils/colors.dart';
import 'package:plantstar/utils/utils.dart';

class SplashPageok extends StatefulWidget {
  @override
  _SplashPageokState createState() => _SplashPageokState();
}

class _SplashPageokState extends State<SplashPageok> {
  @override
  void didChangeDependencies() async {
    Future.delayed(Duration(seconds: 10)).then((value) {
      // Verificar conexões de rede, permissões de acesso, estado de login
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => MobileScreenLayout()));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Change Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );

    final logo = Container(
      height: 500.0,
      width: 500.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AvailableImages.loading,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(gradient: chatBubbleGradient2),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[logo],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
