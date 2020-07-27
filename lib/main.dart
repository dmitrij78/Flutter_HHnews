import 'package:flutter/material.dart';
import 'package:hh_news/src/article.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new RefreshIndicator(
            child: new ListView(
              children:
                  _articles.map((article) => _buildItem(article)).toList(),
            ),
            onRefresh: () async {
              await new Future.delayed(const Duration(seconds: 1));
              setState(() {
                _articles.removeAt(0);
              });
              return;
            }));
  }

  Widget _buildItem(Article article) {
    return new Padding(
      key: Key(article.id.toString()),
      padding: const EdgeInsets.all(16),
      child: ExpansionTile(
        title: new Text(article.title, style: new TextStyle(fontSize: 24.0)),
        subtitle: new Text("${article.score} comments"),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("${article.score}"),
              new IconButton(
                icon: new Icon(Icons.launch),
                color: Colors.deepOrange,
                onPressed: () async {
                  final fakeUrl = "https://${article.url}";
                  if (await canLaunch(fakeUrl)) {
                    launch(fakeUrl);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
