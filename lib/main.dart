import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<double> _accelerometerValues;
double _accelerometerValuesX = 0,
    _accelerometerValuesY = 0,
    _accelerometerValuesZ;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double full_height = MediaQuery.of(context).size.height;
    Size screenSize = MediaQuery.of(context).size;

    gyroscopeEvents.listen((GyroscopeEvent event) {
     
    });

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
        _accelerometerValuesX = event.x;
        _accelerometerValuesY = event.y;
        _accelerometerValuesZ = event.z;
      });
    });

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Color(0xFF445AE3),
        ),
        ClipPath(
          clipper: BackgroundCurveClipper(0.65, 0.95, 0.88, 1.0, 0.75),
          child: Container(
            height: full_height,
            color: Color(0xFF7662E9),
          ),
        ),
        ClipPath(
          clipper: BackgroundCurveClipper(0.70, 0.72, 0.65, 1.0, 0.40),
          child: Container(
            height: full_height,
            color: Color(0xFF9A68ED),
          ),
        ),
        ClipPath(
          clipper: BackgroundCurveClipper(0.75, 0.50, 0.45, 0.95, 0.00),
          child: Container(
            height: full_height,
            color: Color(0xFFCF71F2),
          ),
        ),
        ClipPath(
          clipper: BackgroundCurveClipper(0.450, 0.25, 0.23, 0.5, 0.00),
          child: Container(
            height: full_height,
            color: Color(0xFFEC75F6),
          ),
        ),
        AnimatedBubbles(
            radius: 40, movement: 5, x1: 350, y1: 600, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 15, movement: 8, x1: 260, y1: 550, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 10, movement: 9, x1: 320, y1: 650, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 15, movement: 8, x1: 245, y1: 720, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 20, movement: 7, x1: 295, y1: 800, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 10, movement: 9, x1: 260, y1: 850, x2: 0, y2: 0),
        AnimatedBubbles(
          radius: 40, movement: 5, x1: 65, y1: 725, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 15, movement: 8, x1: 115, y1: 770, x2: 0, y2: 0),
        AnimatedBubbles(
          radius: 20, movement: 7, x1: 75, y1: 825, x2: 0, y2: 0),
        AnimatedBubbles(
            radius: 20, movement: 7, x1: 115, y1: 625, x2: 0, y2: 0),
        AnimatedBubbles(
          radius: 10, movement: 9, x1: 35, y1: 675, x2: 0, y2: 0),
      ],
    ));
  }
}

class AnimatedBubbles extends StatefulWidget {
  double radius, movement, x1, y1, x2, y2;

  AnimatedBubbles(
      {this.radius, this.movement, this.x1, this.y1, this.x2, this.y2});

  @override
  _AnimatedBubblesState createState() => _AnimatedBubblesState();
}

class _AnimatedBubblesState extends State<AnimatedBubbles> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double new_x1 = (widget.x1 + _accelerometerValuesX * widget.movement);
    double new_y1 = (widget.y1 - (_accelerometerValuesY - 3) * widget.movement);

    if (new_x1 < 0) {
      new_x1 = 0;
    } else if (new_x1 > screenSize.width) {
      new_x1 = screenSize.width;
    }

    if (new_y1 < 0) {
      new_y1 = 0;
    } else if (new_y1 > screenSize.height) {
      new_y1 = screenSize.height - 5;
    }

    int duration_time = 1000;

    if (duration_time < 0) {
      duration_time = -duration_time;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: duration_time),
      curve: Curves.decelerate,
      margin: EdgeInsets.fromLTRB(new_x1, new_y1, widget.x2, widget.y2),
      height: widget.radius,
      width: widget.radius,
      decoration: BoxDecoration(
        color: Color(0xFFAF8BEE),
        shape: BoxShape.circle,
        border: Border.all(width: 0.0, color: Color(0xFFAF8BEE)),
      ),
    );
  }
}

class BackgroundCurveClipper extends CustomClipper<Path> {
  double x1, y1, y2, x3, y3;

  BackgroundCurveClipper(x1, y1, y2, x3, y3) {
    this.x1 = x1; // Control point -- x
    this.y1 = y1; // Control point -- y
    this.y2 = y2; // Start Point -- y
    this.x3 = x3; // End point -- x
    this.y3 = y3; // End point -- y
  }

  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height * this.y2);
    path.quadraticBezierTo(size.width * this.x1, size.height * this.y1,
        size.width * this.x3, size.height * this.y3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
