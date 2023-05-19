import 'dart:convert';
import 'package:fuel_station/model/location_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fuel_station/model/cart_model.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:line_icons/line_icons.dart';

import '../main_wrapper.dart';
import '../utils/constants.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage(
      {required this.position, required this.data, super.key});

  final Position position;
  final List<CartModel> data;
  @override
  _OrderSuccessPageState createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  bool _isLoading = true;
  bool _isOrderPlaced = false;

  Future<void> placeOrder() async {
    // Prepare the request body
    List<Map<String, dynamic>> cartDataJson =
        (widget.data).map((cart) => cart.toJson()).toList();

    final position = widget.position;
    final location =
        Location(latitude: position.latitude, longitude: position.longitude);
    Map<String, dynamic> requestBody = {
      'cartData': cartDataJson,
      'position': location,
    };

    String url = '$baseUrl/order';
    final headers = {'Content-Type': 'application/json'};
    final payload = jsonEncode(requestBody);
    final response =
        await http.post(Uri.parse(url), headers: headers, body: payload);

    if (response.statusCode == 200) {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });
      });
      // Simulate order placement delay
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isOrderPlaced = true;
        });
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isLoading = false;
        });
      });
      // Simulate order placement delay
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _isOrderPlaced = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    placeOrder();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainWrapper()),
            (route) => false,
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Order Status",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainWrapper()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  LineIcons.user,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : _isOrderPlaced
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 80.0,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Ordered Successfully!',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 80.0,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Order failed!',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
          ),
        ));
  }
}
