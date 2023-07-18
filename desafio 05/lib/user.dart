// os principais 
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({ Key? key }) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  List _contatos = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/database.json');//aqui esta la no json com os nomes e status 
    final data = await json.decode(response);
    setState(() {
    _contatos = data["contatos"];  
    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 152, 244),//cor 
        title: const Text(
          'Contatos e Status'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('abrir'),
              onPressed: readJson,
              ),
              _contatos.isNotEmpty
              ? Expanded(
                child: ListView.builder(
                  itemCount: _contatos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Text(_contatos[index]["name"]),//<--------
                        title: Text(_contatos[index]["status"]),//<-------- chamando os nomes,status e street do json
                        subtitle: Text(_contatos[index]["street"]),//<--------
                      ),
                    );
                  },
                ),
              )
              : Container()
          ],)
        ),
    );
  }
}

