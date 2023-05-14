import 'package:fuel_station/model/delivery_partner_model.dart';
import '../model/base_model.dart';

class Order {
  final String orderId;
  final BaseModel item; // Add variable of type BaseModel
  final String status;
  DeliveryPartnerModel deliveryPartner;

  Order({
    required this.orderId,
    required this.item,
    required this.status,
    required this.deliveryPartner
  });

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'item': item.toJson(),
        'status': status,
        'deliveryPartner': deliveryPartner.toJson()
      };
}
