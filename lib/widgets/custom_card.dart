import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/configs/themes.dart';
import 'package:chapbox/screens/category_list_screen.dart';
//import 'package:chapbox/models/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class IconCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const IconCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

//
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 40, color: primaryColor),
        title: Text(title, style: TextStyle(fontSize: 20)),
        subtitle: Text(subtitle, style: TextStyle()),
        style: ListTileStyle.list,
        //titleTextStyle: ,
        titleAlignment:
            ListTileTitleAlignment.top /*AlignmentDirectional.topStart*/,
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Iconsax.arrow_right_1,
              weight: 2,
              size: 8,
            )),
        contentPadding: EdgeInsets.all(8.0),
        shape: Border.all(),
      ),
    );
  }
}

class LogoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logo;

  const LogoCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.logo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          logo,
          width: 75,
          height: 75,
        ),
        /*Image.network(logo)*/
        title: Text(title, style: TextStyle(fontSize: 20)),
        subtitle: Text(subtitle, style: TextStyle()),
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

class ImageCard extends StatelessWidget {
  //passage de l'objet en l'occurence shop
  const ImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 4.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: appLightGrey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ]),
        //La box pour garder le contenu descriptif d'un 100% Benin
        child: Column(
          children: [
            //Le contenur de l'image pour pouvoir faire la mise en forme border-radius
            Container(
              margin: EdgeInsetsDirectional.only(bottom: 4.0),
              color:
                  onSecondaryContainerColor.withOpacity(0.5) /*appLightGrey*/,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              //child: Image.network(
              child: Image.asset(
                'images/productsImages/kitkat_nestle_paysage.jpg',
                height: 250,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Nom complet du supermarché
                  //beacoup de variables en attente
                  Text('Supermarché Erevan Calavi'),
                  SizedBox(height: 4.0),
                  //Autres détails
                  Text('Adresse : Calavi Kpota carré ...'),
                  SizedBox(height: 2.0),
                  Text('A 2,6km de votre position'),
                  SizedBox(height: 2.0),
                  //Statut d'ouverture
                  Text('Ouvert ??'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/
class ProductCard extends StatelessWidget {
  //ShopProduct shopProduct;
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //child: Image.network(
      child: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CategoryListScreen() /*ProductDetailsScreen()*/),
                          );
                        },
                        child: Row(
                children: [
                  Container(
                    width: media.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      //borderRadius: BorderRadius.right(10.0),
                    ),
                    //child: Image.network(src, width: media.width * 0.3),
                    child: Image.asset(
                      'images/productsImages/kitkat_nestle_paysage.jpg',
                      
                      //fit: BoxFit.cover,
                      fit: BoxFit.fill,
                    ),
                    /*CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(/*Icons.error */Iconsax.error),
                ),*/
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Titre',
                                  style: ChapboxTheme
                                      .lightTheme.textTheme.bodyLarge,
                                ),
                                Text(
                                  'Boutique',
                                  style: ChapboxTheme
                                      .lightTheme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Prix',
                                      style: ChapboxTheme
                                          .lightTheme.textTheme.bodySmall,
                                    ),
                                    //SizedBox()
                                    Text(
                                      'En stock',
                                      style: ChapboxTheme
                                          .lightTheme.textTheme.bodySmall,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ],
              ),),
              Row(
                children: [
                  IconButton(
                    alignment: AlignmentDirectional.centerEnd,
                    iconSize: 30,
                    onPressed: () {
                      const snackBar =
                          SnackBar(content: Text('Produit ajouté au panier'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      /*setState(() {
                  isOutlined = !isOutlined; // Basculer entre Outlined et Linear
                });*/
                    },
                    icon: Icon(Iconsax.add_square_copy) /*Icon( Iconsax.tick_square_copy)*/ /*Icon(Iconsax.archive_add_copy)*/,
                    /* isOutlined ? Iconsax.home_outline : Iconsax.home_linear, */
                    tooltip: 'Ajouter au panier',
                    color: primaryColor,
                    disabledColor: appGrey,
                    selectedIcon: Icon(Iconsax.archive_minus),
                    isSelected: false,
                  ),
                ],
              )
            ],
          ),

          /*const snackBar = SnackBar(content: Text('Produit ajouté au panier'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  //Order order;
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            //child: Image.network('src'),
            child: Image.asset(
              'images/productsImages/kitkat_nestle_paysage.jpg',
              width: 50,
              height: 50,
            ),
          )
        ],
      ),
    );
  }
}
