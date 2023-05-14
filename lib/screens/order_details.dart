import 'package:fuel_station/model/base_model.dart';
import 'package:fuel_station/model/delivery_partner_model.dart';
import 'package:fuel_station/model/orders_model.dart';
import 'package:fuel_station/screens/order_information.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';

import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Order> orders = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String url = '${baseUrl}/order';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final List<Order> orders = data.map<Order>((orderData) {
        // Extract the necessary data from each orderData object
        final orderId = orderData['orderId'];
        final itemData = orderData['item'];
        final status = orderData['status'];
        final deliveryPartnerData = orderData['deliveryPartner'];

        // Create the BaseModel object
        final item = BaseModel(
          id: itemData['id'],
          imageUrl: itemData['imageUrl'],
          name: itemData['name'],
          price: itemData['price'].toDouble(),
          review: itemData['review'].toDouble(),
          star: itemData['star'].toDouble(),
          value: itemData['value'],
          quantity: itemData['quantity'],
        );

        // Create the DeliveryPartnerModel object
        final deliveryPartner = DeliveryPartnerModel(
          deliveryPartnerId: deliveryPartnerData['deliveryPartnerId'],
          deliveryTime: deliveryPartnerData['deliveryTime'],
          deliveryPartnerMobileNumber:
              deliveryPartnerData['deliveryPartnerMobileNumber'],
          deliveryPartnerLocation:
              deliveryPartnerData['deliveryPartnerLocation'],
        );

        // Create and return the Order object
        return Order(
          orderId: orderId,
          item: item,
          status: status,
          deliveryPartner: deliveryPartner,
        );
      }).toList();

      setState(() {
        this.orders = orders;
        print(orders);
      });
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrderInformation(order: orders[index]),
                ));
              },
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListTile(
                  leading: Image.asset(orders[index].item.imageUrl),
                  title: Text(orders[index].item.name),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Delivery Time: ${orders[index].deliveryPartner.deliveryTime}'),
                      Text('Price: ${orders[index].item.price}'),
                    ],
                  ),
                  trailing: Icon(
                    orders[index].status != "Pending"
                        ? Icons.check_circle
                        : Icons.watch_later,
                    color: orders[index].status != "Pending"
                        ? Colors.green
                        : Color.fromARGB(185, 244, 67, 54),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
