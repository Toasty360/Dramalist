import 'package:isar/isar.dart';
part 'drama.g.dart';

@Collection()
class Drama {
  Id? id;
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
  IsarLinks<Drama> recommendations = IsarLinks<Drama>();
  List<Cast>? cast;
  List<String>? images;
  String? totalViewersCount;
  String? director;
  List<Episode>? episodes;
  int? releasedAt;
  String? aired;
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
    List<Drama>? recommendations,
    this.cast,
    this.images,
    this.totalViewersCount,
    this.director,
    this.episodes,
    this.releasedAt,
  }) {
    if (recommendations != null) {
      this.recommendations.addAll(recommendations);
    }
  }

  @override
  String toString() {
    return 'Drama(id: $id, title: $title, originalTitle: $originalTitle, description: $description, genres: $genres, altTitles: $altTitles, totalEpisodes: $totalEpisodes, rank: $rank, popularity: $popularity, country: $country, category: $category, type: $type, url: $url, poster: $poster, cover: $cover, rating: $rating, year: $year, isEnded: $isEnded, tags: $tags, reviews: $reviews, recommendations: $recommendations, cast: $cast, images: $images, totalViewersCount: $totalViewersCount, director: $director, episodes: $episodes, releasedAt: $releasedAt)';
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
      recommendations: [],
    );
  }
}

@Embedded()
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

  @override
  String toString() {
    return 'Episode(number: $number, title: $title, overview: $overview, airDate: $airDate, season: $season, rating: $rating, image: $image)';
  }
}

@Embedded()
class Reviews {
  String? image;
  String? name;
  String? review;
  Reviews({this.image, this.name, this.review});
  @override
  String toString() => 'Reviews(image: $image, name: $name, review: $review)';
}

@Embedded()
class Cast {
  String? name;
  String? image;
  String? characterName;
  String? role;

  Cast({this.name, this.image, this.characterName, this.role});

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
  topDramas,
  topMovies,
  varietyShows,
  newestDramas,
  newestMovies,
}
