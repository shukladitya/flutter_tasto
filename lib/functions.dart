import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

String name;
int nosugg = 20;
Response response;
String choisename;
String taste;
String yturl;
String tastedetails;
String tastewiki;
List<Widget> suggcard = [];

///////////like system///////////
List<String> liked_movies = [];
List<String> liked_series = [];
List<String> liked_games = [];
List<String> liked_books = [];
List<String> liked_podcast = [];
List<String> liked_music = [];
List<String> liked_author = [];
List<String> liked_movies_c = [];
List<String> liked_series_c = [];
List<String> liked_games_c = [];
List<String> liked_books_c = [];
List<String> liked_podcast_c = [];
List<String> liked_music_c = [];
List<String> liked_author_c = [];
void servingfunction(String content, String type) {
  if (type == 'movie' && (liked_movies.contains(content) == false)) {
    liked_movies.add(content);
    setsaveddatamovies(liked_movies);
    getsaveddatamovies();
  }
  if (type == 'show' && (liked_series.contains(content) == false)) {
    liked_series.add(content);
    setsaveddataseries(liked_series);
    getsaveddataseries();
  }
  if (type == 'game' && (liked_games.contains(content) == false)) {
    liked_games.add(content);
    setsaveddatagames(liked_games);
    getsaveddatagames();
  }
  if (type == 'book' && (liked_books.contains(content) == false)) {
    liked_books.add(content);
    setsaveddatabooks(liked_books);
    getsaveddatabooks();
  }
  if (type == 'podcast' && (liked_podcast.contains(content) == false)) {
    liked_podcast.add(content);
    setsaveddatapodcast(liked_podcast);
    getsaveddatapodcast();
  }
  if (type == 'music' && (liked_music.contains(content) == false)) {
    liked_music.add(content);
    setsaveddatamusic(liked_music);
    getsaveddatamusic();
  }
  if (type == 'author' && (liked_author.contains(content) == false)) {
    liked_author.add(content);
    setsaveddataauthor(liked_author);
    getsaveddataauthor();
  }
}

void setsaveddatamovies(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistmovies', passed);
}

void setsaveddataseries(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistseries', passed);
}

void setsaveddatagames(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistgames', passed);
}

void setsaveddatabooks(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistbooks', passed);
}

void setsaveddatapodcast(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistpodcast', passed);
}

void setsaveddatamusic(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistmusic', passed);
}

void setsaveddataauthor(List passed) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setStringList('cashedlistauthor', passed);
}

///////////////////////spitting
void getsaveddatamovies() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_movies_c = preferences.getStringList('cashedlistmovies');
  liked_movies = liked_movies_c ?? [];
  print('ok2');
}

void getsaveddataseries() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_series_c = preferences.getStringList('cashedlistseries');
  liked_series = liked_series_c ?? [];
}

void getsaveddatagames() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_games_c = preferences.getStringList('cashedlistgames');
  liked_games = liked_games_c ?? [];
}

void getsaveddatabooks() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_books_c = preferences.getStringList('cashedlistbooks');
  liked_books = liked_books_c ?? [];
}

void getsaveddatapodcast() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_podcast_c = preferences.getStringList('cashedlistpodcast');
  liked_podcast = liked_podcast_c ?? [];
}

void getsaveddatamusic() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_music_c = preferences.getStringList('cashedlistmusic');
  liked_music = liked_music_c ?? [];
}

void getsaveddataauthor() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  liked_author_c = preferences.getStringList('cashedlistauthor');
  liked_author = liked_author_c ?? [];
}

var decoded;
