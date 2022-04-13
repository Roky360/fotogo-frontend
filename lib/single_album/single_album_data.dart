import 'package:fotogo/album_details/album_details_data.dart';

import '../fotogo_protocol/data_types.dart';

class SingleAlbumData {
  AlbumDetailsData detailsData;
  List<ImageData> imagesData;

  SingleAlbumData(this.detailsData, this.imagesData);
}
