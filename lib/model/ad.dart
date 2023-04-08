class Ad {
  final int id;
  final String? lat;
  final String? lng;
  final String file;
  final String? instagram;
  final String? website;
  final String local_title;
  final String local_description;

  Ad({
    required this.id,
    this.lat,
    this.lng,
    required this.file,
    this.instagram,
    this.website,
    required this.local_title,
    required this.local_description,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
        id: json['id'],
        file: json['file'],
        local_title: json['local_title'],
        local_description: json['local_description'],
        lat: json['lat'],
        lng: json['lng'],
        instagram: json['instagram'],
        website: json['website']);
  }
}
