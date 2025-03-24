import 'package:chapbox/configs/styles.dart';
import 'package:chapbox/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:chapbox/screens/auth/register_screen.dart';


//étape 1

class StepScreen extends StatefulWidget {
  const StepScreen({super.key});

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  int? selectedPage = 0;
  final PageController _controller = PageController();

  List<Map<String, dynamic>> infos = [
    {
      "title": "Recherche rapide",
      "subtitle": "Trouvez les supermarchés proches de vous sans vous déplacer",
      //"icon": "icons/white_search_icon.png"
      "icon": "assets/icons/loupe.png"
      
    },
    {
      "title": "Accès instantané aux informations des produits",
      "subtitle": "Vérifiez la disponibilité d'un produit dans un supermarché",
      //"icon": "assets/icons/card-list.svg"
      "icon": "assets/icons/carte.png"
    },
    {
      "title": "Commandez facilement",
      "subtitle":
          "Ajoutez les articles que vous désirez à votre panier et payer en quelques clics",
      "icon": "assets/images/empty_shopping_cart_image.png"
      //"icon": "assets/icons/cart-check.svg"
    },
    {
      "title": "Livraison flexible",
      "subtitle":
          "Choisissez de récupérer votre colis en magasin ou d'etre livré n'importe selon vos besoins",
      //"icon": "assets/icons/send.svg"
      "icon": "assets/icons/camion.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      selectedPage = _controller.page?.round() ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
  }

/*
  void navigateToLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  void navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen(deviceId: '',)));
  }*/

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SafeArea(
          child: Container(
            //width: media.width * 0.85,
            padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: infos.length,
              itemBuilder: (context, index) {
                var currentObject = infos[index] as Map? ?? {};
                return 
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: media.width * 0.5,
                      height: media.height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(currentObject["icon"].toString()),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Text(
                      currentObject["title"].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: media.width * 0.03,
                    ),
                    Text(
                      currentObject["subtitle"].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    //LineIcon.addToShoppingCart(),
                  ],
                );
              },
            ),
            //inutile parce que MainAxisAlignment.end envoie cette colonne au pied
            // de son conteneur(qui est aussi une colonne)
            SizedBox(
              height: media.width * 0.7,
            ),
            Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: infos.map((currentObject) {
                    var index = infos.indexOf(currentObject);

                    return Container(
                      margin: EdgeInsetsDirectional.symmetric(horizontal: media.width * 0.02),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: selectedPage == index
                              ? Colors.white
                              : Colors.white60,
                          borderRadius: BorderRadius.circular(7.5)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white/*const Color.fromARGB(255, 148, 84, 84)*/,
                    foregroundColor: primaryColor,
                    elevation: 0.0,
                    fixedSize: Size(media.width*0.75, media.height*0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                    //side: ,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterScreen(/*deviceId: '',*/)));
                  },
                  child: Text(
                    'S\'inscrire',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //HomeScreen()));
                                BaseScaffold()));
                  },
                  style: OutlinedButton.styleFrom(
                    textStyle: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
                    //padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                    alignment: Alignment.center,
                    backgroundColor: null,
                    elevation: 0.0,
                    fixedSize: Size(media.width*0.75, media.height*0.06),
                    side: BorderSide(
                        color: Colors.white,
                        width: 2,
                        style: BorderStyle.solid),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Passer',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            ),
            //Padding(),
          ],
        ),
          ),
      ),
      ),
    );
  }
}
