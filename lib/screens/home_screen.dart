/// This is the home page of application.
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Title"),

        ), body: getBody());
  }

  Widget getBody() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black12,
      padding: const EdgeInsets.all(10),
      child: ListView(
          shrinkWrap: true,
          children: List.generate(5, (int index) {
            return getListContentWidget(index);
          })),
    );
  }

  Widget getListContentWidget(int index) {
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        color: Colors.white,
        margin: EdgeInsets.only(top: index != 0 ? 11 : 0),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 24, left: 22, top: 22, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Title",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(
                height: 3,
              ),
              Text("Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 12)),
              SizedBox(
                height: 3,
              ),
            ],
          ),
        ));
  }
}
