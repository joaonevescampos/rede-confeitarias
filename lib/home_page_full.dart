import 'package:flutter/material.dart';

class HomePageFull extends StatefulWidget {
  @override
  HomePageFullState createState() => HomePageFullState();
}

class HomePageFullState extends State<HomePageFull> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: 
      Column(
        children: [
          Container(
            height: 300, 
            color: Colors.blue, 
            child: 
            Center(
              child: Text(
                'Clique aqui', 
                style: TextStyle(color: Colors.white),
              )
            )
          ),
          SizedBox(height: 20,),
          Container(
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10)
                ),
               
                child: Text(
                  'clique aqui',
                  style: TextStyle(
                    fontSize: 30,
                    backgroundColor: Colors.amber,
                  ),
                  ),
              ),
              onTap: () {
              setState(() {
                counter++;
              });
            },
            ),
          ),
          SizedBox(height: 50,),
          Container(
            child: Text('contagem: $counter', style: TextStyle(fontSize: 20),),
          )

        ],
      )
      
    );
  }
}