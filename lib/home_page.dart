import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text(
          'João Campos', 
          style: TextStyle(color: Colors.amber)),
        actions: [Center(child: Text('olá')),],
      ),
      drawer: Drawer(),
      body: Center(
              child: 
                Container(
                  height: 300, 
                  width: 500, 
                  color: Colors.amber, 
                  child: Column(mainAxisAlignment: 
                  MainAxisAlignment.spaceAround, 
                  
                  children: [
                    SizedBox(height: 50,),
                    Text('teste1'), 
                    Text('teste2'), 
                    Text('teste3'), 
                    Text('teste1'), 
                    Text('teste2'), 
                    Text('teste3'), 
                    Text('teste1'), 
                    Text('teste2'), 
                    Text('teste555'),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Text('col 1'),
                      Text('col 1'),
                      Text('col 1'),
                      Text('col 545415211'),
                      Text('col 100000'),
                    ],)
                    ],
                    ),
                  ),
                )        
      );
  }
}
