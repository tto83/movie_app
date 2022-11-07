import 'package:flutter/material.dart';

import '../model/movie.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

  //const MovieListView({Key? key}) : super(key: key);

  // final List movies = [   //not needed when movieList is created
  //   "Titanic",
  //   "Blade runner",
  //   "Rambo",
  //   "The Avenfers",
  //   "Avatar",
  //   "I Am Legend",
  //   "300",
  //   "The Wolf of Wall Street",
  //   "Interstellar",
  //   "Game of Thrones",
  //   "Vikings"
  // ];

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
          
        // OLD CARD:
        // return Card(
        //   color: Colors.white,
        //   elevation: 3,
        //   child: ListTile(
        //
        //     leading: CircleAvatar(
        //       child: Container(
        //         width: 200,
        //         height: 200,
        //         decoration: BoxDecoration(
        //           //color: Colors.blue,
        //           image: DecorationImage(
        //             image: NetworkImage(movieList[index].images[0]),
        //             fit: BoxFit.cover
        //           ),
        //           borderRadius: BorderRadius.circular(13.9)
        //         ),
        //         child: null, //Text("H"),
        //       ),
        //     ),
        //
        //     trailing: Text("..."),
        //
        //     title: Text("${movieList[index].title}"),
        //     subtitle: Text("${movieList[index].genre}"), //you can pass text buy not only, e.g. a widget
        //
        //     //onTap: () => debugPrint("Movie name: ${movies[index]}"),
        //
        //     onTap: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => MovieListViewDetails(movieName: movieList.elementAt(index).title, movie: movieList[index],)));
        //     },
        //   ),
        // );
          
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

      // body: Center(
      //   child: Container(
      //     child: ElevatedButton(
      //       child: Text("Go back ${this.movie.director}"),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //   ),
      // )

      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie)
        ],
      )

    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  //const MovieDetailsThumbnail({Key? key}) : super(key: key);

  final String thumbnail;

  const MovieDetailsThumbnail({super.key, required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            )
          ],
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            // gradient: RadialGradient(
            //   center: Alignment.center,
            //   colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
            //   radius: 1.1
            // )
          ),
          height: 80,
        ),
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  //const MovieDetailsHeaderWithPoster({Key? key}) : super(key: key);

  final Movie movie;

  const MovieDetailsHeaderWithPoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[1].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(
              child: MovieDetailsHeaderPoster(movie: movie)
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  //const MoviePoster({Key? key}) : super(key: key);
  
  final String poster;

  const MoviePoster({super.key, required this.poster});

  @override
  Widget build(BuildContext context) {
    var borderRadious = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadious,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover
            ),
          ),

        ),
      ),
    );
  }
}

class MovieDetailsHeaderPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.cyan
          ),
        ),
        Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32
          )
        )
      ],
    );
  }
}