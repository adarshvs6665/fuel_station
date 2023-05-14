class DeliveryPartnerModel {
  final String deliveryPartnerId;
  final String deliveryTime;
  final String deliveryPartnerMobileNumber;
  String deliveryPartnerLocation;

  DeliveryPartnerModel({
    required this.deliveryPartnerId,
    required this.deliveryTime,
    required this.deliveryPartnerMobileNumber,
    required this.deliveryPartnerLocation,
  });

  Map<String, dynamic> toJson() => {
        'deliveryPartnerId': deliveryPartnerId,
        'deliveryTime': deliveryTime,
        'deliveryPartnerMobileNumber': deliveryPartnerMobileNumber,
        'deliveryPartnerLocation': deliveryPartnerLocation
      };
}
