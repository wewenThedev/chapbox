import 'package:http/http.dart' as http;

   Future<String> initiatePayment(double amount) async {
     final response = await http.post(
       Uri.parse('https://your-api-url.com/api/create-transaction'),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(<String, dynamic>{
         'amount': amount,
       }),
     );

     if (response.statusCode == 200) {
       final data = jsonDecode(response.body);
       return data['payment_url']; // URL pour rediriger l'utilisateur vers FedaPay
     } else {
       throw Exception('Failed to create transaction');
     }
   }

      import 'package:url_launcher/url_launcher.dart';

   void openPaymentUrl(String url) async {
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       throw 'Could not launch $url';
     }
   }

