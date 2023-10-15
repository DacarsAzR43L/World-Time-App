import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};


  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String bgimage = data['isDayTime'] ? 'day.jpeg' : 'night.jpeg';
    Color? bgColor = data['isDayTime'] ? Colors.amber[100]: Colors.lightBlue[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/$bgimage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0,0 ,0),
            child: Column(
              children: <Widget>[

                TextButton.icon(
                onPressed:() async {
                  dynamic result = await Navigator.pushNamed(context, '/location');

                  setState(() {
                    data ={
                      'time':result['time'],
                      'location':result['location'],
                      'isDayTime':result['isDayTime'],
                      'flag': result['flag'],
                    };
                  });
                },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    label: Text('Edit Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    )),

                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
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
