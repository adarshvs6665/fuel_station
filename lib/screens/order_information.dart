import 'package:animate_do/animate_do.dart';
import 'package:fuel_station/model/orders_model.dart';
import 'package:fuel_station/widget/reuseable_row_for_cart.dart';
import 'package:fuel_station/widget/reuseable_text%20.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class OrderInformation extends StatefulWidget {
  final Order order;

  const OrderInformation({Key? key, required this.order}) : super(key: key);

  @override
  _OrderInformationState createState() => _OrderInformationState();
}

class _OrderInformationState extends State<OrderInformation> {
  // List<Order> orders = [];

  String responseBody = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    Order order = widget.order;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Order Information",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      order.item.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        width: size.width,
                        height: size.height * 0.36,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 1.0),
                            child: Column(
                              children: [
                                FadeInUp(
                                  delay: const Duration(milliseconds: 350),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        order.item.name,
                                        style: textTheme.displaySmall
                                            ?.copyWith(fontSize: 16),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_sharp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 400),
                                  child: Text(
                                    'Integer vitae arcu et eros lacinia interdumInteger vitae arcu et eros lacinia interdumInteger vitae arcu et eros lacinia interdum. ',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 450),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Status",
                                            style: textTheme.headline5
                                                ?.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                        Text(
                                          order.status != 'Pending'
                                              ? 'Completed'
                                              : 'Pending',
                                          style: TextStyle(
                                            color: order.status != 'Pending'
                                                ? Colors.green
                                                : Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 400),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Quantity",
                                            style: textTheme.headlineSmall
                                                ?.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                        ReuseableTextComponent(
                                          inputText: order.item.quantity,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 400),
                                  child: const ReuseableRowForCart(
                                    price: 22,
                                    text: 'Sub Total',
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 400),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Delivery",
                                            style: textTheme.headlineSmall
                                                ?.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                        ReuseableTextComponent(
                                          inputText: order
                                              .deliveryPartner.deliveryTime,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                FadeInUp(
                                  delay: const Duration(milliseconds: 400),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Order id",
                                            style: textTheme.headlineSmall
                                                ?.copyWith(
                                                    color: Colors.grey,
                                                    fontSize: 16)),
                                        const ReuseableTextComponent(
                                          inputText: "f32db08b-acfe-4c68-bb74",
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

// class OrderInformation extends StatelessWidget {
//   final Order order;

//   const OrderInformation({super.key, required this.order});

//   void fetchData() async {
//     print("inside");
//     final response =
//         await http.get(Uri.parse('http://localhost:3000/api/v1/default'));
//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Order Information",
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_rounded,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               LineIcons.user,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Card(
//               margin: const EdgeInsets.only(bottom: 16.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: AspectRatio(
//                   aspectRatio: 1,
//                   child: Image.asset(
//                     order.image,
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 padding: const EdgeInsets.all(16.0),
//                 width: size.width,
//                 height: size.height * 0.36,
//                 color: Colors.white,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 1.0),
//                     child: Column(
//                       children: [
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 350),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 order.name,
//                                 style: textTheme.displaySmall
//                                     ?.copyWith(fontSize: 16),
//                               ),
//                               const Icon(
//                                 Icons.arrow_forward_ios_sharp,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ),
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 400),
//                           child: Text(
//                             'Integer vitae arcu et eros lacinia interdumInteger vitae arcu et eros lacinia interdumInteger vitae arcu et eros lacinia interdum. ',
//                             style: Theme.of(context).textTheme.bodyLarge,
//                           ),
//                         ),
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 450),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 12.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Status",
//                                     style: textTheme.headline5?.copyWith(
//                                         color: Colors.grey, fontSize: 16)),
//                                 Text(
//                                   order.completed ? 'Completed' : 'Pending',
//                                   style: TextStyle(
//                                     color: order.completed
//                                         ? Colors.green
//                                         : Colors.orange,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 400),
//                           child: const ReuseableRowForCart(
//                             price: 22,
//                             text: 'Sub Total',
//                           ),
//                         ),
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 400),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 12.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Delivery",
//                                     style: textTheme.headlineSmall?.copyWith(
//                                         color: Colors.grey, fontSize: 16)),
//                                 ReuseableTextComponent(
//                                   inputText: order.deliveryTime,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         FadeInUp(
//                           delay: const Duration(milliseconds: 400),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 12.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Order id",
//                                     style: textTheme.headlineSmall?.copyWith(
//                                         color: Colors.grey, fontSize: 16)),
//                                 const ReuseableTextComponent(
//                                   inputText: "f32db08b-acfe-4c68-bb74",
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
