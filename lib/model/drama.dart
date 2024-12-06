// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Drama {
  int? id;
  String? title;
  String? originalTitle;
  String? description;
  List<String>? genres;
  List<String>? altTitles;
  int? totalEpisodes;
  int? rank;
  int? popularity;
  String? country;
  String? category;
  String? type;
  String url;
  String? poster;
  String? cover;
  double? rating;
  String? year;
  bool? isEnded;
  List<String>? tags;
  List<Reviews>? reviews;
  List<Drama>? recommendations;
  List<Cast>? cast;
  List<String>? images;
  String? totalViewersCount;
  String? director;
  List<Episode>? episodes;
  int? releasedAt;
  Drama({
    this.id,
    this.title,
    this.originalTitle,
    this.description,
    this.genres,
    this.altTitles,
    this.totalEpisodes,
    this.rank,
    this.popularity,
    this.country,
    this.category,
    this.type,
    required this.url,
    this.poster,
    this.cover,
    this.rating,
    this.year,
    this.isEnded,
    this.tags,
    this.reviews,
    this.recommendations,
    this.cast,
    this.images,
    this.totalViewersCount,
    this.director,
    this.episodes,
    this.releasedAt,
  });

  @override
  String toString() {
    return 'Drama(id: $id, title: $title, originalTitle: $originalTitle, description: $description, genres: $genres, altTitles: $altTitles, totalEpisodes: $totalEpisodes, rank: $rank, popularity: $popularity, country: $country, category: $category, type: $type, url: $url, poster: $poster, cover: $cover, rating: $rating, year: $year, isEnded: $isEnded, tags: $tags, reviews: $reviews, recommendations: $recommendations, cast: $cast, images: $images, totalViewersCount: $totalViewersCount, director: $director, episodes: $episodes, releasedAt: $releasedAt)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'originalTitle': originalTitle,
      'description': description,
      'genres': genres,
      'altTitles': altTitles,
      'totalEpisodes': totalEpisodes,
      'rank': rank,
      'popularity': popularity,
      'country': country,
      'category': category,
      'type': type,
      'url': url,
      'poster': poster,
      'cover': cover,
      'rating': rating,
      'year': year,
      'isEnded': isEnded,
      'tags': tags,
      'reviews': reviews?.map((x) => x.toMap()).toList(),
      'recommendations': recommendations?.map((x) => x.toMap()).toList(),
      'cast': cast?.map((x) => x.toMap()).toList(),
      'images': images,
      'totalViewersCount': totalViewersCount,
      'director': director,
      'episodes': episodes?.map((x) => x.toMap()).toList(),
      'releasedAt': releasedAt,
    };
  }

  factory Drama.fromSchedule(Map<String, dynamic> item) {
    return Drama(
      url: item["url"],
      id: item["id"],
      rank: item["ranking"],
      popularity: item["popularity"],
      country: item["country"],
      category: item["content_type"],
      type: item["type"],
      description: item["synopsis"],
      genres: item["genres"]?.split(',') ?? [],
      poster: item["thumbnail"],
      cover: item["cover"],
      title: item["title"],
      rating: item["rating"]?.toDouble(),
      releasedAt: item["released_at"],
    );
  }

  factory Drama.fromMap(Map<String, dynamic> map) {
    return Drama(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      originalTitle:
          map['originalTitle'] != null ? map['originalTitle'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      genres:
          map['genres'] != null
              ? List<String>.from((map['genres'] as List<String>))
              : null,
      altTitles:
          map['altTitles'] != null
              ? List<String>.from((map['altTitles'] as List<String>))
              : null,
      totalEpisodes:
          map['totalEpisodes'] != null ? map['totalEpisodes'] as int : null,
      rank: map['rank'] != null ? map['rank'] as int : null,
      popularity: map['popularity'] != null ? map['popularity'] as int : null,
      country: map['country'] != null ? map['country'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      url: map['url'] as String,
      poster: map['poster'] != null ? map['poster'] as String : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      year: map['year'] != null ? map['year'] as String : null,
      isEnded: map['isEnded'] != null ? map['isEnded'] as bool : null,
      tags:
          map['tags'] != null
              ? List<String>.from((map['tags'] as List<String>))
              : null,
      reviews:
          map['reviews'] != null
              ? List<Reviews>.from(
                (map['reviews'] as List<int>).map<Reviews?>(
                  (x) => Reviews.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      recommendations:
          map['recommendations'] != null
              ? List<Drama>.from(
                (map['recommendations'] as List<int>).map<Drama?>(
                  (x) => Drama.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      cast:
          map['cast'] != null
              ? List<Cast>.from(
                (map['cast'] as List<int>).map<Cast?>(
                  (x) => Cast.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      images:
          map['images'] != null
              ? List<String>.from((map['images'] as List<String>))
              : null,
      totalViewersCount:
          map['totalViewersCount'] != null
              ? map['totalViewersCount'] as String
              : null,
      director: map['director'] != null ? map['director'] as String : null,
      episodes:
          map['episodes'] != null
              ? List<Episode>.from(
                (map['episodes'] as List<int>).map<Episode?>(
                  (x) => Episode.fromMap(x as Map<String, dynamic>),
                ),
              )
              : null,
      releasedAt: map['releasedAt'] != null ? map['releasedAt'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Drama.fromJson(String source) =>
      Drama.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Episode {
  int? number;
  String? title;
  String? overview;
  String? airDate;
  int? season;
  double? rating;
  String? image;
  Episode({
    this.number,
    this.title,
    this.overview,
    this.airDate,
    this.season,
    this.rating,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'title': title,
      'overview': overview,
      'airDate': airDate,
      'season': season,
      'rating': rating,
      'image': image,
    };
  }

  factory Episode.fromMap(Map<String, dynamic> map) {
    return Episode(
      number: map['number'] != null ? map['number'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      airDate: map['airDate'] != null ? map['airDate'] as String : null,
      season: map['season'] != null ? map['season'] as int : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Episode.fromJson(String source) =>
      Episode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Episode(number: $number, title: $title, overview: $overview, airDate: $airDate, season: $season, rating: $rating, image: $image)';
  }
}

class Reviews {
  String? image;
  String? name;
  String? review;
  Reviews({this.image, this.name, this.review});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'image': image, 'name': name, 'review': review};
  }

  factory Reviews.fromMap(Map<String, dynamic> map) {
    return Reviews(
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      review: map['review'] != null ? map['review'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reviews.fromJson(String source) =>
      Reviews.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Reviews(image: $image, name: $name, review: $review)';
}

class Cast {
  String? name;
  String? image;
  String? characterName;
  String? role;
  Cast({this.name, this.image, this.characterName, this.role});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'characterName': characterName,
      'role': role,
    };
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      characterName:
          map['characterName'] != null ? map['characterName'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cast.fromJson(String source) =>
      Cast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cast(name: $name, image: $image, characterName: $characterName, role: $role)';
  }
}

enum DramaCatalog {
  upcomingMovies,
  upcomingDramas,
  popularMovies,
  popularDramas,
  varietyShows,
}
