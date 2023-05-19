import 'package:fuel_station/model/base_model.dart';
import 'package:fuel_station/model/delivery_partner_model.dart';
import 'package:fuel_station/model/location_model.dart';
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

  List<Order> parseOrders(List<dynamic> json) {
    return json.map((order) {
      final orderId = order['orderId'] as String;
      final itemJson = order['item'] as Map<String, dynamic>;
      final status = order['status'] as String;
      final deliveryPartnerJson =
          order['deliveryPartner'] as Map<String, dynamic>?; // Make it nullable
      final deliveryLocationJson =
          order['deliveryLocation'] as Map<String, dynamic>;

      final item = BaseModel.fromJson(itemJson);
      DeliveryPartnerModel? deliveryPartner; // Make it nullable

      if (deliveryPartnerJson != null) {
        deliveryPartner = DeliveryPartnerModel.fromJson(deliveryPartnerJson);
      }

      final deliveryLocation = Location.fromJson(deliveryLocationJson);

      return Order(
        orderId: orderId,
        item: item,
        status: status,
        deliveryPartner: deliveryPartner,
        deliveryLocation: deliveryLocation,
      );
    }).toList();
  }

  Future<void> fetchData() async {
    String url = '${baseUrl}/order';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final List<Order> orders = parseOrders(data);

      setState(() {
        this.orders = orders;
      });
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  // Future<void> fetchData() async {
  //   String url = '${baseUrl}/order';
  //   print(url);
  //   final response = await http.get(Uri.parse(url));
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body) as List<dynamic>;
  //     // print(data);

  //     // List<Order> parseOrders(List<dynamic> json) {
  //     //   return json.map((order) {
  //     //     final orderId = order['orderId'] as String;
  //     //     final itemJson = order['item'] as Map<String, dynamic>;
  //     //     final status = order['status'] as String;
  //     //     final deliveryPartnerJson =
  //     //         order['deliveryPartner'] as Map<String, dynamic>;
  //     //     final deliveryPartnerLocationJson =
  //     //         deliveryPartnerJson['deliveryPartnerLocation']
  //     //             as Map<String, dynamic>;

  //     //     final item = BaseModel.fromJson(itemJson);
  //     //     final deliveryPartner =
  //     //         DeliveryPartnerModel.fromJson(deliveryPartnerJson);
  //     //     final deliveryLocation = Location.fromJson(deliveryPartnerLocationJson);

  //     //     return Order(
  //     //       orderId: orderId,
  //     //       item: item,
  //     //       status: status,
  //     //       deliveryPartner: deliveryPartner,
  //     //       deliveryLocation: deliveryLocation,
  //     //     );
  //     //   }).toList();
  //     // }

  //     // print(parseOrders(data));
  //     final List<Order> orders = parseOrders(data);

  //     setState(() {
  //       this.orders = orders;
  //     });
  //   } else {
  //     throw Exception('Failed to fetch orders');
  //   }
  // }

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
                      if (orders[index].status == "PENDING") ...[
                        const Text('Delivery Time: Not set')
                      ] else if (orders[index].status == "DELIVERY") ...[
                        Text(
                            'Delivery Time: ${orders[index].deliveryPartner?.deliveryTime}')
                      ],
                      Text('Price: ${orders[index].item.price}'),
                    ],
                  ),
                  trailing: Icon(
                    orders[index].status != "PENDING"
                        ? Icons.check_circle
                        : Icons.watch_later,
                    color: orders[index].status != "PENDING"
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
