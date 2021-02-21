import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../design_patterns/proxy/customer/customer.dart';
import '../../../../design_patterns/proxy/customer/customer_details.dart';
import '../../../../design_patterns/proxy/icustomer_details_service.dart';
import '../../../platform_specific/platform_button.dart';
import 'customer_details_column.dart';

class CustomerDetailsDialog extends StatefulWidget {
  final Customer customer;
  final ICustomerDetailsService service;

  const CustomerDetailsDialog({
    @required this.customer,
    @required this.service,
  })  : assert(customer != null),
        assert(service != null);

  @override
  _CustomerDetailsDialogState createState() => _CustomerDetailsDialogState();
}

class _CustomerDetailsDialogState extends State<CustomerDetailsDialog> {
  @override
  void initState() {
    super.initState();

    widget.service
        .getCustomerDetails(widget.customer.id)
        .then((CustomerDetails customerDetails) => setState(() {
              widget.customer.details = customerDetails;
            }));
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.customer.name),
      content: SizedBox(
        height: 200.0,
        child: widget.customer.details == null
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: lightBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black.withOpacity(0.65),
                  ),
                ),
              )
            : CustomerDetailsColumn(
                customerDetails: widget.customer.details,
              ),
      ),
      actions: <Widget>[
        Visibility(
          visible: widget.customer.details != null,
          child: PlatformButton(
            materialColor: Colors.black,
            materialTextColor: Colors.white,
            onPressed: _closeDialog,
            child: const Text('Close'),
          ),
        ),
      ],
    );
  }
}
