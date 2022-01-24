import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return MaterialApp(
          //       debugShowCheckedModeBanner: false,
          //       home: Splash()
          //   );
          // } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Davidly Screener',
              theme: ThemeData(
                appBarTheme: AppBarTheme(
                  backwardsCompatibility: false, // 1
                  systemOverlayStyle: SystemUiOverlayStyle.light, // 2
                ),
                backgroundColor: Colors.black,
                scaffoldBackgroundColor: Colors.black,
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              home: Splash(),
            );
          // }
        }
    );
  }
}

class InputName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class DailyScreener extends StatelessWidget {
  DailyScreener(this.name);
  final String name;

  String month = "...";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(height);

    DateTime date = DateTime.now();
    print(date);
    print('name: $name');

    switch (date.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Center(
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(top: height-(height*0.066*1.54)),
                  child: Container(
                    color: Color.fromRGBO(87, 6, 138, 1),
                    height: height*0.066,
                  ),
                ),
                Container(
                  color: Color.fromRGBO(87, 6, 138, 1),
                  height: height*0.065,
                ),
                Center(
                  child: Image.asset(
                    'daily_screener.jpg',
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: (height-32)*0.33, right: height>=907 ? 280 : (height-42)*0.3),
                    child: Text('$name\n${date.day} $month 2022', style: TextStyle(color: Color.fromRGBO(64, 64, 64, 1), letterSpacing: 1.0, fontSize: height*0.03, fontFamily: "Roboto", fontWeight: FontWeight.w300),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String name = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(102, 1, 145, 1),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 50.0,),
              Form(
                child: Container(
                  width: 200.0,
                  height: 60.0,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        name = val.trim();
                        print('name: $name');
                      });
                    },
                    // autocorrect: false,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                      hintText: 'Type first and last name',
                      // border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 20.0),
              InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  print('name: $name');
                  if (name.length > 16) {
                    setState(() {
                      error = 'Name has to be up to 16 characters';
                    });
                  } else if (name.split(' ').length <=1 || name.split(' ').length >2) {
                    setState(() {
                      error = 'Type only first and last name';
                    });
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DailyScreener(convertToTitleCase(name))));
                  }
                },
                child: Container(
                  width: size.width * 0.5,
                  height: 65.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.black12,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Suck my dick, NYU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Container(
                  child: Image.asset('assets/nyu_logo.png'),
                width: 200.0,
              ),
            ],
          )
      ),
    );
  }
}

String convertToTitleCase(String text) {
  if (text == null) {
    return '';
  }

  if (text.length <= 1) {
    return text.toUpperCase();
  }

  // Split string into multiple words
  final List<String> words = text.split(' ');

  // Capitalize first letter of each words
  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }
    return '';
  });

  // Join/Merge all words back to one String
  return capitalizedWords.join(' ');
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 2));
  }
}
