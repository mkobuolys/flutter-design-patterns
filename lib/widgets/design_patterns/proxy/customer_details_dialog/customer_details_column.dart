import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../design_patterns/proxy/customer/customer_details.dart';
import 'customer_info_group.dart';

class CustomerDetailsColumn extends StatelessWidget {
  final CustomerDetails customerDetails;

  const CustomerDetailsColumn({
    @required this.customerDetails,
  }) : assert(customerDetails != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomerInfoGroup(
          label: 'E-mail',
          text: customerDetails.email,
        ),
        const SizedBox(height: spaceL),
        CustomerInfoGroup(
          label: 'Position',
          text: customerDetails.position,
        ),
        const SizedBox(height: spaceL),
        CustomerInfoGroup(
          label: 'Hobby',
          text: customerDetails.hobby,
        ),
      ],
    );
  }
}
