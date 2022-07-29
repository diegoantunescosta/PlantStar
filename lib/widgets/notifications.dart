import 'package:flutter/material.dart';
import 'package:plantstar/utils/utils.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

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

    final notificationHeader = Center(
      child: Text(
        "Em breve teremos novidades",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
      ),
    );
    final notificationText = Text(
      "Em breve teremos novidades",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.grey.withOpacity(0.6),
      ),
      textAlign: TextAlign.center,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        title: Text('Identificação de plantas'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFFFFCA7A), Color(0xFFFF918D)]),
          ),
        ),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[logo, notificationHeader, notificationText],
            ),
          ],
        ),
      ),
    );
  }
}
