class RadioChannel {
  final int id;
  final String name;
  final String subtitle;
  final String bodcaster;
  final String image;
  final String bodcasterImage;
  final String url;
  final String enName;
  final String enSubtitle;
  RadioChannel({
    required this.enName,
    required this.enSubtitle,
    required this.url,
    required this.bodcasterImage,
    required this.id,
    required this.name,
    required this.subtitle,
    required this.bodcaster,
    required this.image,
  });

  factory RadioChannel.fromJson(Map<String, dynamic> json) {
    return RadioChannel(
        url: json['url'],
        id: json['id'],
        name: json['name'],
        subtitle: json['subtitle'],
        bodcaster: json['bodcaster'],
        image: json['image'],
        bodcasterImage: json['bodcasterImage'],
        enName: json['enName'],
        enSubtitle: json['enSubtitle']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subtitle': subtitle,
      'bodcaster': bodcaster,
      'image': image,
    };
  }
}
