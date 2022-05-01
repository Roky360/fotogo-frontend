import 'package:fotogo/album_details/album_data.dart';

import '../fotogo_protocol/data_types.dart';

class SingleAlbumData {
  AlbumData data;
  List<ImageData>? imagesData;

  SingleAlbumData({required this.data, this.imagesData});
}
