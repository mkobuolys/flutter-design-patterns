import 'customer/customer_details.dart';

abstract class ICustomerDetailsService {
  Future<CustomerDetails> getCustomerDetails(String id);
}
