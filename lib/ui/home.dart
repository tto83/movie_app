import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {

  //const MovieListView({Key? key}) : super(key: key);

  final List movies = [
    "Titanic",
    "Blade runner",
    "Rambo",
    "The Avenfers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueGrey.shade400,

      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),

      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, index) {
        return Card(
          color: Colors.white,
          elevation: 3,
          child: ListTile(

            leading: CircleAvatar(
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(13.9)
                ),
                child: Text("H"),
              ),
            ),

            trailing: Text("..."),

            title: Text(movies[index]),
            subtitle: Text("Subtitle"), //you can pass text buy not only, e.g. a widget

            //onTap: () => debugPrint("Movie name: ${movies[index]}"),

            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListViewDetails(movieName: movies.elementAt(index),)));
            },
          ),
        );
      }),

    );
  }
}

//new route
class MovieListViewDetails extends StatelessWidget {
  //const MovieListViewDetails({Key? key}) : super(key: key);

  final String movieName;

  const MovieListViewDetails({super.key, required this.movieName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),

      body: Center(
        child: Container(
          child: ElevatedButton(
            child: Text("Go back ${this.movieName}"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      )

    );
  }
}

