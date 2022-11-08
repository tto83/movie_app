import 'package:flutter/material.dart';

import '../../model/movie.dart';

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
              height: 170,
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
        ),
        Text.rich(
            TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
                children: <TextSpan> [
                  TextSpan(
                    text: movie.plot,
                  ),
                  TextSpan(
                      text: " More...",
                      style: TextStyle(
                        color: Colors.indigo,
                      )
                  )
                ]
            )
        ),
      ],
    );
  }
}


class MovieDetailsCast extends StatelessWidget {

  final Movie movie;

  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Writer", value: movie.writer),
          MovieField(field: "Awards", value: movie.awards),
          MovieField(field: "Language", value: movie.language),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;
  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field: ",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              //color: Colors.black38,
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieExtraPosters extends StatelessWidget {
  final List<String> posters;
  const MovieExtraPosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "More Movie Posters".toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black26
            ),
          ),
        ),
        Container(
          height: 180,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 8,), //empty space between posters
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(posters[index]),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
            ),
          ),
        )
      ],
    );
  }
}