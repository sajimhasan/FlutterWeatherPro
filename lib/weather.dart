import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_01/weatherstate/weatherstate.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation:0,
       systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        
       ),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    shape: BoxShape.circle,

                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    shape: BoxShape.circle,

                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,

                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100,sigmaY: 100),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent,),
                ),
                 ),
                 SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('📍Balla-Kalihati-Tangail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),),
                      SizedBox(height: 10,),
                      Text('Good Morning',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                         
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("images/8.png",
                            
                            fit: BoxFit.cover,
                            
                            ),
                          ),
                          
                      ),
                      
                      

                   ),
                   
                   Center(child: Text('23°C',
                   style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                   ),)),
                  //  SizedBox(height: 5,),
                   Center(
                    child: Text('THONDERSTORM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    )
                    ),
                    Center(child: RealTimeClock(textStyle:  TextStyle(
                      fontSize: 20,
                      color: Colors.white70
                    ),)
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("images/3.png",
                        scale: 4,) ,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sunset',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            Text('5:29 PM',style: TextStyle(
                              color: Colors.white
                            ),)
                          ],
                        )                 
                      ],
                    ),SizedBox(height: 10,),
                  
                      Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("images/6.png",
                        scale: 4,) ,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sunrise',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            Text('6:45 AM',style: TextStyle(
                              color: Colors.white
                            ),)
                          ],
                        )                 
                      ],
                    ), SizedBox(height: 10,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("images/5.png",
                        scale: 4,) ,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Low Temperature',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            Text('18°C',style: TextStyle(
                              color: Colors.white
                            ),)
                          ],
                        )                 
                      ],
                    ),SizedBox(height: 10,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("images/4.png",
                        scale: 4,) ,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('High Temperature',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),),
                            Text('21°C',style: TextStyle(
                              color: Colors.white
                            ),)
                          ],
                        )                 
                      ],
                    )



                    
                    ],
                  ),
                  
                  
                 ),   
            ],
          ),
        ),
      ),
    );
  }
}