class Movie {
  final int id;
  final String title;
  final String titleLong;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String synopsis;
  final String ytTrailerCode;
  final String language;
  final String backgroundImage;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final List<Torrent> torrents;

  Movie({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    required this.backgroundImage,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.torrents,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      titleLong: json['title_long'],
      year: json['year'],
      rating: json['rating'].toDouble(),
      runtime: json['runtime'],
      genres: List<String>.from(json['genres']),
      summary: json['summary'],
      descriptionFull: json['description_full'],
      synopsis: json['synopsis'],
      ytTrailerCode: json['yt_trailer_code'],
      language: json['language'],
      backgroundImage: json['background_image'],
      smallCoverImage: json['small_cover_image'],
      mediumCoverImage: json['medium_cover_image'],
      largeCoverImage: json['large_cover_image'],
      torrents: List<Torrent>.from(json['torrents'].map((x) => Torrent.fromJson(x))),
    );
  }
}

class Torrent {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final String size;
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;

  Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) {
    return Torrent(
      url: json['url'],
      hash: json['hash'],
      quality: json['quality'],
      type: json['type'],
      size: json['size'],
      sizeBytes: json['size_bytes'],
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],
    );
  }
}