import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImage({super.key, required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Galerie"),
      ),
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        pageController: PageController(initialPage: initialIndex),
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.5,
          );
        },
        scrollPhysics: BouncingScrollPhysics(), // Effet fluide lors du swipe
      ),
    );
  }
}

/* **Explication :**  
- **`PhotoViewGallery.builder`** → Permet de **swiper entre plusieurs images**.  
- **`PhotoViewGalleryPageOptions`** → Ajoute **le zoom** sur chaque image.  
- **`minScale` et `maxScale`** → Définissent les niveaux de zoom.  
- **`scrollPhysics: BouncingScrollPhysics()`** → Effet rebond fluide en swipe.  
*/

/*
class FullScreenImage extends StatefulWidget {
  const FullScreenImage({super.key});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/
