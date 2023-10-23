import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery/gallery/image_detail.dart';
import 'package:native_shutter_sound/native_shutter_sound.dart';
import 'package:photo_manager/photo_manager.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  Future<List<AssetEntity>> _getAlbums() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps != PermissionState.authorized) {
      // _albums = await PhotoManager.getAssetPathList(onlyAll: true);
      // final AssetPathEntity album = albums.first;
      // print(albums.length);
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Permission'),
            content: Text('Permission not granted, please allow access to photos in settings.'),
          ),
        );
      }
    }
    final albums = await PhotoManager.getAssetPathList(hasAll: true, onlyAll: true, type: RequestType.image);
    final recentAlbum = albums.first;

    // Now that we got the album, fetch all the assets it contains
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );
    return recentAssets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Gallery', style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder<List<AssetEntity>>(
        future: _getAlbums(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data'));
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No data'));
          }

          final assets = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemCount: assets.length,
            itemBuilder: (context, index) => FutureBuilder<File?>(
              future: assets[index].file,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Icon(Icons.image_not_supported));
                }
                if (!snapshot.hasData) {
                  return const Center(child: Icon(Icons.image_not_supported));
                }
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: GestureDetector(
                    onTap: () {
                      NativeShutterSound.play();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ImageDetail(file: snapshot.data!)),
                      ); // Image.file(snapshot.data!
                    },
                    child: Hero(
                      tag: 'image${snapshot.data!.path}',
                      child: Image.file(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
