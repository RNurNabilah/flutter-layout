import 'package:flutter/material.dart';
import 'package:mdday4/JsonPage.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          title: Text('Chats'),
        ),
        body: Center(
            child: Container(
                decoration: BoxDecoration(color: Colors.lightBlue),
                child: FutureBuilder(
                  future: readJsonData(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<JsonPage>;
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            items[index].avatar.toString()),
                                        //fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    items[index]
                                                            .fName
                                                            .toString() +
                                                        " " +
                                                        items[index]
                                                            .lName
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (items[index]
                                                              .messages !=
                                                          null) ...[
                                                        Text(
                                                          items[index]
                                                              .lastSeenTime
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors
                                                                  .greenAccent,
                                                          radius: 12,
                                                          child: Text(
                                                            items[index].messages ==
                                                                    null
                                                                ? ' '
                                                                : items[index]
                                                                    .messages
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ] else ...[
                                                        Text(
                                                          items[index]
                                                              .lastSeenTime
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                        ),
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 12,
                                                        ),
                                                      ]
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(
                                                items[index].uName.toString()),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(
                                                items[index].status.toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15)),
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ))));
  }

  Future<List<JsonPage>> readJsonData() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/files/flutterlayout.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => JsonPage.fromJson(e)).toList();
  }
}
