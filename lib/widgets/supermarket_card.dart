import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/models/supermarket.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:cached_network_image/cached_network_image.dart';

class SupermarketCard extends StatefulWidget {
  Supermarket supermarket;

  SupermarketCard({super.key, required this.supermarket});

  @override
  State<SupermarketCard> createState() => _SupermarketCardState();
}

class _SupermarketCardState extends State<SupermarketCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: widget.supermarket.logo?.url != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8), // Coins arrondis
                child:
                    /*
                CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
                 */
                    Image.network(widget.supermarket.logo!.url, // URL du logo
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                  return Image(
                    image: AssetImage('assets/images/exclamationPoint.png'),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  );
                } // Image de secours si l'URL est invalide

                        ),
              )
            : Image(
                image: AssetImage('assets/images/exclamationPoint.png'),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
        /*Image.network(logo)*/
        title: Text(
          widget.supermarket.name,
          style: ChapboxTheme.lightTheme.textTheme.bodyLarge,
        ),
        /*subtitle:
            Text('${widget.supermarket.shops?.length} au Bénin', style: ChapboxTheme.lightTheme.textTheme.bodyMedium),
        */
        subtitle: Text(
            '${widget.supermarket.address} ${widget.supermarket.legalInfo}',
            style: ChapboxTheme.lightTheme.textTheme.bodyMedium),
        style: ListTileStyle.list,
        //titleTextStyle: ,
        titleAlignment:
            ListTileTitleAlignment.top /*AlignmentDirectional.topStart*/,
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.arrow_right_1,
              /*Iconsax.arrow_square_right*/
              weight: 2,
              size: 8,
            )),
        contentPadding: EdgeInsets.all(8.0),
        shape: Border.all(),
      ),
    );
  }
}
