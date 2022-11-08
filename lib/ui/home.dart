import 'package:flutter/material.dart';

import '../model/movie.dart';
import 'movie_ui/movie_ui.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueGrey.shade900,

      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),

      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, index) {
        return Stack(
            children: [
              Positioned(
                  child: movieCard(movieList[index], context)
              ),
              Positioned(
                  top: 14,
                  child: movieImage(movieList[index].images[0])
              ),
            ]
        );

      }),

    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 50.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 40),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white
                          )
                        ),
                      ),
                      Text(
                        "Rating: ${movie.imdbRating} / 10",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(child: Text("Released: ${movie.released}", style: mainTextStyle())),
                      Text(movie.runtime, style: mainTextStyle(),),
                      Text(movie.rated, style: mainTextStyle(),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),

      //onTap: () => debugPrint(movie.title), //test purpose

      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListViewDetails(movieName: movie.title, movie: movie,)));
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(
      fontSize: 15,
      color: Colors.grey,
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? 'https://picsum.photos/300/300'),
          fit: BoxFit.cover
        )
      ),
    );
  }
}

//new route
class MovieListViewDetails extends StatelessWidget {
  //const MovieListViewDetails({Key? key}) : super(key: key);

  final String movieName;
  final Movie movie;

  const MovieListViewDetails({super.key, required this.movieName, required this.movie});
  //const MovieListViewDetails({Key key, this.movieName, this.movie}) : super(key: key);  //this doesn't work

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),

      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieExtraPosters(posters: movie.images,)
        ],
      )

    );
  }
}