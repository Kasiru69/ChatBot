import 'dart:convert';

import 'package:chatappflutter/Function.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _c=1;
  final _formkey=GlobalKey<FormState>();
  final _textController=TextEditingController();
  String _str="",_url="",_link="http://api.brainshop.ai/get?bid=156451&key=RdjOJWhMeR2JDdOW&uid=[uid]&msg=";
  String _Link="http://127.0.0.1:5000/api?query=";
  List<String> arr=[];
  List<String> brr=[];
  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.black26,
          ),
          //image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.travelandleisure.com%2Ftrip-ideas%2Fspace-astronomy%2Fearth-from-space&psig=AOvVaw0_u0-8yF0ZvEqhIbO7mifc&ust=1696921595672000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMjumdqz6IEDFQAAAAAdAAAAABAE'),
          child:Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //image: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.travelandleisure.com%2Ftrip-ideas%2Fspace-astronomy%2Fearth-from-space&psig=AOvVaw0_u0-8yF0ZvEqhIbO7mifc&ust=1696921595672000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCMjumdqz6IEDFQAAAAAdAAAAABAE'),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  width: MediaQuery.of(context). size. width,
                  child: ListView.builder(reverse:true,itemCount:arr.length,itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.green,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("You"),
                              SizedBox(height: 10,),
                              Text("${arr[arr.length-index-1]}")
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Bot"),
                              SizedBox(height: 10,),
                              Text("${brr[arr.length-index-1]}")
                            ],
                          ),
                        )
                      ],
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Container(
                        height: 75,
                        width: MediaQuery.of(context).size.width-100,
                        child:TextFormField(
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value)
                          {
                            _str=value.toString();
                          },
                          controller: _textController,
                          decoration: InputDecoration(
                              hintText: 'Enter a message here',
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              )
                          ),
                        )
                      ),
                      IconButton(onPressed: ()async{
                        _url=_link+_str;
                        data=await fetchdata(_url);
                        var decode=jsonDecode(data);
                        setState(() {
                          arr.add(_str);
                          _textController.clear();
                          brr.add(decode['cnt']);
                          //print("decode['output']");
                          _c++;
                        });
                      }, icon: Icon(Icons.send))
                    ],
                )
              ],
            ),
          ),
        )
      )
    );
  }
}



