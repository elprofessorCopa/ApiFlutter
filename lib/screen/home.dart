import 'dart:convert';

import'package:flutter/material.dart';

import '../model/user.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget{

   HomeScreen({Key?key}) : super(key:key);
@override
State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<User> users =[];
  @override
Widget build(BuildContext context){
  return Scaffold(

    appBar:AppBar(
      title: const Text('rest APi call'),

    ),
    body:ListView.builder(
      itemCount:users.length,
      itemBuilder:(context,index){
        final user = users[index];
        return ListTile(
          leading:CircleAvatar(

            child:Text('${index +1}'),
          ),


            title:Text(user.name.last),
            subtitle:Text(user.phone),
        );

      },
    ),
    floatingActionButton:FloatingActionButton(
      onPressed:fetchUsers,
    ),
  );
}

void fetchUsers()async{
  print('fetchuser called');
  const url ='https://randomuser.me/api/?results=20';
  final uri =Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json =jsonDecode(body);
  final results=json['results'] as List<dynamic>;
  final transformed = results.map((e) {
    final name = UserName(
      title: e['name']['title'],
      first: e['name']['first'],
      last: e['name']['last'],
    );

    return User(
      cell: e['cell'],
      email: e['email'],
      gender: e['gender'],
      nat: e['nat'],
      phone: e['phone'],
      name: name,
    );
  }).toList();

  setState((){
     users= transformed;
  });
  print(" fetchuser completed");
}
}
