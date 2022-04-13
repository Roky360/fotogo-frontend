// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fotogo/fotogo_protocol/data_types.dart';
// import 'package:fotogo/fotogo_protocol/client.dart';
// import 'package:fotogo/screens/albums/album_data.dart';
//
// import '../screens/create_album_schedule/album_schedule_data.dart';
//
// class AlbumService {
//   final Client _client;
//
//   AlbumService(this._client);
//
//   Future createAlbumSchedule(
//       BuildContext context, AlbumScheduleData data) async {
//     final idToken = await context.read<UserBloc>().idToken;
//   }
//
//   Future getAlbumsDetails(BuildContext context) async {
//     final idToken = await context.read<UserBloc>().idToken;
//
//     final Response response = _client.sendRequest(Request(
//       requestType: RequestType.getAlbumDetails,
//       idToken: idToken,
//     ));
//
//     if (response.statusCode == StatusCode.ok) {
//       return List.generate(response.payload.length, (index) {
//         final currAlbum = response.payload[index];
//
//         return AlbumData(
//             id: currAlbum['album_id'],
//             title: currAlbum['name'],
//             dates: DateTimeRange(
//                 start: DateTime.parse(currAlbum['date_range'][0]),
//                 end: DateTime.parse(currAlbum['date_range'][1])),
//             isShared: false,
//             images: [
//               ImageData(
//                   data: MemoryImage(base64Decode(currAlbum['cover_image'])),
//                   fileName: '',
//                   containingAlbums: [])
//             ],
//             // ADD IS_SHARED PROPERTY
//             tags: currAlbum['tags']);
//       });
//     } else {
//       throw Exception("${response.statusCode}: ${response.payload}");
//     }
//   }
//
//   Future getAlbumContents(BuildContext context, String albumId) async {
//     final idToken = await context.read<UserBloc>().idToken;
//
//     final Response response = _client.sendRequest(Request(
//         requestType: RequestType.getAlbumContents,
//         idToken: idToken,
//         args: {'album_id': albumId}));
//
//     if (response.statusCode == StatusCode.ok) {
//       return List.generate(response.payload.length, (index) {
//         final currImage = response.payload[index];
//
//         return ImageData(
//             fileName: currImage['file_name'],
//             timestamp: DateTime.tryParse(currImage['timestamp']),
//             containingAlbums: currImage['containing_albums'].cast<String>(),
//             tag: currImage['tag'],
//             data: MemoryImage(base64Decode(currImage['data'])));
//       });
//     } else {
//       throw Exception("${response.statusCode}: ${response.payload}");
//     }
//   }
//
//   void updateAlbum(BuildContext context) async {
//     final idToken = await context.read<UserBloc>().idToken;
//   }
//
//   void addToAlbum(BuildContext context) async {
//     final idToken = await context.read<UserBloc>().idToken;
//   }
//
//   void removeFromAlbum(BuildContext context) async {
//     final idToken = await context.read<UserBloc>().idToken;
//   }
//
//   void buildAlbum(BuildContext context) async {} // if using AI
//
//   void deleteAlbum(BuildContext context) async {
//     final idToken = await context.read<UserBloc>().idToken;
//   }
// }
