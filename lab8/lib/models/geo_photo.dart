import 'package:hive_flutter/hive_flutter.dart';

class GeoPhoto extends HiveObject {
  GeoPhoto({
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  String imagePath;
  double latitude;
  double longitude;
  DateTime createdAt;
}

class GeoPhotoAdapter extends TypeAdapter<GeoPhoto> {
  @override
  final int typeId = 1;

  @override
  GeoPhoto read(BinaryReader reader) {
    return GeoPhoto(
      imagePath: reader.readString(),
      latitude: reader.readDouble(),
      longitude: reader.readDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, GeoPhoto obj) {
    writer.writeString(obj.imagePath);
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
