import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantstar/screens/login_screen.dart';
import 'package:plantstar/screens/signup_screen.dart';
import 'package:plantstar/utils/colors.dart';
import 'package:plantstar/utils/utils.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );

    final logo = Container(
      height: 100.0,
      width: 60.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AvailableImages.appLogo,
          fit: BoxFit.cover,
        ),
      ),
    );

    final appName = Column(
      children: <Widget>[
        Text(
          'PlantStart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        Text(
          "Rede de colaboração",
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w500),
        )
      ],
    );

    final group = Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/devpage'),
        child: Center(
          child: Text(
            'Bem vindo a rede das plantas',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    final loginBtn = InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      ),
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.green.shade900),
          color: Colors.green.shade900,
        ),
        child: Center(
          child: Text(
            'ENTRAR',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    final CadastrarBtn = InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        ),
      ),
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.green.shade900),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'CADASTRAR',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: Colors.green.shade900,
            ),
          ),
        ),
      ),
    );

    final buttons = Padding(
      padding: EdgeInsets.only(
        top: 80.0,
        bottom: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Column(
        children: <Widget>[loginBtn, SizedBox(height: 20.0), CadastrarBtn],
      ),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 100.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  logo,
                  appName,
                  buttons,
                  group,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
