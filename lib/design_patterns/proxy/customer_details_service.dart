import 'package:faker/faker.dart';

import 'customer/customer_details.dart';
import 'icustomer_details_service.dart';

class CustomerDetailsService implements ICustomerDetailsService {
  @override
  Future<CustomerDetails> getCustomerDetails(String id) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        final email = faker.internet.email();
        final hobby = faker.sport.name();
        final position = faker.job.title();

        return CustomerDetails(id, email, hobby, position);
      },
    );
  }
}
