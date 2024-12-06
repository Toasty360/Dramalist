import 'package:dio/dio.dart';
import 'package:dramalist/model/drama.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class DramaList {
  static String baseUrl = 'http://140.82.10.197:9080';
  static final Dio _dio = Dio();

  static Future<Drama> getPreview(int id) async {
    final response = await _dio.get('$baseUrl/v1/titles/$id');
    if (response.statusCode == 200) {
      final data = response.data;
      return Drama(
        id: data['id'],
        url: data['url'],
        title: data['title'],
        originalTitle: data['original_title'],
        description: data['synopsis'],
        genres:
            (data['genres'] as List)
                .map((e) => e["name"] ?? "")
                .toList()
                .cast<String>(),
        altTitles: data['alt_titles'].split(';').cast<String>(),
        totalEpisodes: data['episodes'],
        rank: data['rank'],
        popularity: data['popularity'],
        country: data['country'],
        type: data['type'],
        poster: data['thumbnail'],
        cover: data['cover'],
        rating: data['rating'],
        year: data['year'],
        isEnded: data['ended'],
      );
    } else {
      throw Exception('Failed to get drama preview');
    }
  }

  static List<Drama> _cardScapper(String data) {
    var doc = parse(data);
    List<Drama> dramas =
        doc.querySelectorAll('.container-fluid [id^="mdl-"].box').sublist(0).map((
          ele,
        ) {
          RegExpMatch? match = RegExp(
            r'^(?<country>[\w\s]+)\s-\s(?<year>\d{4}),\s(?<totalepisodes>\d+)\s+episodes$',
          ).firstMatch(ele.querySelector("span.text-muted")?.text ?? "");
          return Drama(
            url: ele.querySelector('a')?.attributes['href'] ?? "",
            id: int.parse(ele.id.split("-")[1]),
            title: ele.querySelector('.title')?.text.trim() ?? "",
            country: match?.namedGroup("country") ?? "",
            year: match?.namedGroup("year").toString() ?? "0",
            totalEpisodes:
                int.tryParse(
                  match?.namedGroup("totalepisodes").toString() ?? "0",
                ) ??
                0,
            rating: double.tryParse(
              ele.querySelector("span.score")?.text.trim() ?? "0",
            ),
            description: ele
                .querySelectorAll("p")
                .last
                .text
                .trim()
                .replaceAll('\n', " "),
            rank: int.tryParse(
              ele.querySelector('.ranking')?.text.trim().replaceAll('#', "") ??
                  "0",
            ),
            cover:
                ele.querySelector('img.cover')?.attributes['data-src'] ??
                "not found",
          );
        }).toList();
    return dramas;
  }

  static Future<List<Drama>> search(String query) async {
    final response = await _dio.get('$baseUrl/search?q=$query');
    if (response.statusCode == 200) {
      final data = response.data;
      return _cardScapper(data);
    } else {
      throw Exception('Failed to search dramas');
    }
  }

  static String _getEndpoint(DramaCatalog catalog) {
    switch (catalog) {
      case DramaCatalog.upcomingMovies:
        return '/movies/upcoming';
      case DramaCatalog.upcomingDramas:
        return '/shows/upcoming';
      case DramaCatalog.popularMovies:
        return '/movies/popular';
      case DramaCatalog.popularDramas:
        return '/shows/popular';
      case DramaCatalog.varietyShows:
        return '/shows/variety';
    }
  }

  static Future<List<Drama>> getDramas(DramaCatalog catalog) async {
    var endpoint = _getEndpoint(catalog);
    final response = await _dio.get('$baseUrl$endpoint');
    if (response.statusCode == 200) {
      final data = response.data;
      return _cardScapper(data);
    } else {
      throw Exception('Failed to get $catalog');
    }
  }

  static Future<Drama> info(String path) async {
    final responses = await Future.wait([
      _dio.get('$baseUrl$path'),
      _dio.get('$baseUrl$path/photos'),
      _dio.get('$baseUrl$path/episodes'),
      _dio.get('$baseUrl$path/cast'),
    ]);
    final response = responses.first;
    var images = _getImages(responses[1].data);
    var episodes = _getEpisodes(responses[2]);
    var cast = _getCast(responses[3].data);
    if (response.statusCode == 200) {
      var doc = parse(response.data);
      Drama drama = Drama(
        id: int.tryParse(path.split("-").first.substring(1)) ?? 0,
        url: path,
        title: doc.querySelector('.film-title')?.text.split("(").first ?? "",
        rating: double.tryParse(
          doc.querySelector(".col-film-rating")?.text.trim() ?? "0",
        ),
        description:
            doc
                .querySelector('.show-synopsis span')
                ?.text
                .trim()
                .replaceAll('\n', " ") ??
            "N/A",
        cover: doc.querySelector('.film-cover img')?.attributes['src'] ?? "",
        genres:
            doc
                .querySelectorAll(".show-genres .text-primary")
                .map((e) => e.text.trim())
                .toList(),
        tags:
            doc
                .querySelectorAll(".show-tags .text-primary")
                .map((e) => e.text.trim())
                .toList(),
        totalViewersCount: doc.querySelectorAll(".hfs b").last.text.trim(),
        category:
            doc.querySelector('.content-rating')?.text.split(":").last.trim(),
      );
      var sideContents = doc
          .querySelectorAll('.content-side .box')
          .sublist(0, 2);
      sideContents.first.querySelectorAll('.list-item').forEach((e) {
        if (e.text.trim().contains("Country")) {
          drama.country = e.text.trim().split(":").last.trim();
        } else if (e.text.trim().contains("Aired:") ||
            e.text.trim().contains("Release")) {
          drama.year = e.text.trim().split(":").last.trim();
        } else if (e.text.trim().contains("Episodes")) {
          drama.totalEpisodes =
              int.tryParse(e.text.trim().split(":").last.trim()) ?? 0;
        }
      });
      sideContents.last.querySelectorAll('.list-item').forEach((e) {
        if (e.text.trim().contains("Ranked")) {
          drama.rank =
              int.tryParse(e.text.trim().split(":").last.trim().substring(1)) ??
              99999;
        } else if (e.text.trim().contains("Popularity")) {
          drama.popularity =
              int.tryParse(e.text.trim().split(":").last.trim().substring(1)) ??
              0;
        }
      });

      doc.querySelectorAll(".show-detailsxss .list-item").forEach((e) {
        if (e.text.trim().contains("Native")) {
          drama.originalTitle = e.text.trim().split(":").last.trim();
        } else if (e.text.trim().contains("Also Known As:")) {
          drama.altTitles =
              e.text
                  .trim()
                  .split(":")
                  .last
                  .trim()
                  .split(",")
                  .map((e) => e.trim())
                  .toList();
        } else if (e.text.trim().contains("Director")) {
          drama.director = e.text.trim().split(":").last.trim();
        }
      });
      drama.poster = images.isNotEmpty ? images.first : "";
      drama.images = images;
      drama.episodes = episodes;
      drama.cast = cast;
      drama.reviews = _getReviews(doc);
      return drama;
    }
    throw Exception("Failed to get drama info");
  }

  static List<Episode> _getEpisodes(Response response) {
    if (response.statusCode == 200) {
      var doc = parse(response.data);
      return doc
          .querySelectorAll('.episode')
          .map(
            (e) => Episode(
              number: int.tryParse(
                e.querySelector('.title')?.text.split(" ").last ?? "0",
              ),
              title:
                  e.querySelector('.title')?.text ??
                  e
                      .querySelector('a')
                      ?.attributes['href']
                      ?.split('/')
                      .last
                      .trim(),
              airDate: e.querySelector('.air-date')?.text ?? "",
              rating: double.tryParse(
                e.querySelector('.rating-panel b')?.text.trim() ?? "0",
              ),
              image: e.querySelector('img')?.attributes['data-src'] ?? "",
            ),
          )
          .toList();
    }
    return [];
  }

  static List<String> _getImages(String data) {
    try {
      RegExp regExp = RegExp(
        r'''<img\s+class="img-responsive"[^>]*\s+src=["\'](https?://[^"\']+)["\']''',
        caseSensitive: false,
      );
      return regExp
          .allMatches(data)
          .map((Match match) => match.group(1)!)
          .toList();
    } catch (e) {
      return [];
    }
  }

  static List<Reviews> _getReviews(Document doc) {
    return doc
        .querySelectorAll(".review")
        .map(
          (e) => Reviews(
            image: e.querySelector("img")?.attributes["src"] ?? "",
            name: e.querySelector("b")?.text.trim() ?? "",
            review:
                e
                    .querySelector(".review-body")
                    ?.nodes
                    .where((node) => node.nodeType == Node.TEXT_NODE)
                    .map((e) => e.text?.trim().replaceAll("\n", " ") ?? "")
                    .join()
                    .trim(),
          ),
        )
        .toList();
  }

  static List<Cast> _getCast(String data) {
    var doc = parse(data);
    return [
      ...DramaList._addCastFromRole(doc, "Main Role", []),
      ...DramaList._addCastFromRole(doc, "Support Role", []),
    ];
  }

  static List<Cast> _addCastFromRole(
    Document doc,
    String roleTitle,
    List<Cast> castList,
  ) {
    doc
        .querySelectorAll("h3")
        .firstWhere((h3) => h3.text.contains(roleTitle))
        .nextElementSibling
        ?.querySelectorAll(".list-item")
        .forEach((e) {
          castList.add(
            Cast(
              name: e.querySelector("b")?.text.trim() ?? "",
              image: e.querySelector("img")?.attributes["src"] ?? "",
              characterName:
                  e.querySelector("small .text-primary")?.text.trim() ?? "",
              role: e.querySelector(".text-muted")?.text.trim() ?? "",
            ),
          );
        });
    return castList;
  }

  static Future<Map<int, List<Drama>>> schedule() async {
    Map<int, List<Drama>> cal = {};
    final response = await _dio.get('$baseUrl/v1/episode_calendar?lang=en-US');
    if (response.statusCode == 200) {
      final data = response.data;
      var a = {for (var item in data["relationships"] ?? []) item["id"]: item};

      DateTime time;
      data["items"]?.forEach((item) {
        time = DateTime.fromMillisecondsSinceEpoch(
          (item["released_at"] as int) * 1000,
        );
        if (cal.containsKey(time.day)) {
          cal[time.day]?.add(
            Drama.fromSchedule(a[item["rid"] as int])
              ..releasedAt = item["released_at"]
              ..totalEpisodes = item["episode_number"],
          );
        } else {
          cal[time.day] = [
            Drama.fromSchedule(a[item["rid"] as int])
              ..releasedAt = item["released_at"]
              ..totalEpisodes = item["episode_number"],
          ];
        }
      });
    }
    return cal;
  }
}

void main(List<String> args) {}
