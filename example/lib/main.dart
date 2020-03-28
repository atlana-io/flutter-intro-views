import 'package:flutter/material.dart';
import 'package:flutter_intro_views/models/page_view_model.dart';
import 'package:flutter_intro_views/onboarding.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final pages = [
    PageViewModel(
      background: Container(
        color: Color(0xFF03A9F4),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 10.0,
                right: 10.0,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 50.0),
                child: Text("Flights"),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: new EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                ),
                child: new Container(
                  child: Image.asset(
                    'assets/airplane.png',
                    height: 285.0,
                    width: 285.0,
                    alignment: Alignment.center,
                  ), //Loading main
                ), //Container
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 75.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24.0),
                  textAlign: TextAlign.center,
                  child: Text(
                    'Haselfree  booking  of  flight  tickets  with  full  refund  on  cancelation',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bubble: Image.asset('assets/air-hostess.png'),
    ),
    PageViewModel(
      background: Container(
        color: Color(0xFF8BC34A),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 10.0,
                right: 10.0,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 50.0),
                child: Text("Hotels"),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: new EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                ),
                child: new Container(
                  child: Image.asset(
                    'assets/hotel.png',
                    height: 285.0,
                    width: 285.0,
                    alignment: Alignment.center,
                  ), //Loading main
                ), //Container
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 75.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24.0),
                  textAlign: TextAlign.center,
                  child: Text(
                    'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bubble: Image.asset('assets/waiter.png'),
    ),
    PageViewModel(
      background: Container(
        color: Color(0xFF607D8B),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 10.0,
                right: 10.0,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 50.0),
                child: Text("Cabs"),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: new EdgeInsets.only(
                  top: 20.0,
                  bottom: 40.0,
                ),
                child: new Container(
                  child: Image.asset(
                    'assets/taxi.png',
                    height: 285.0,
                    width: 285.0,
                    alignment: Alignment.center,
                  ), //Loading main
                ), //Container
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 75.0,
                  left: 10.0,
                  right: 10.0,
                ),
                child: DefaultTextStyle.merge(
                  style: TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 24.0),
                  textAlign: TextAlign.center,
                  child: Text(
                    'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bubble: Image.asset('assets/taxi-driver.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => Onboarding(
          pages,
          showNextButton: false,
          showBackButton: false,
          showSkipButton: false,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text("This is the home page of the app"),
      ),
    );
  }
}
