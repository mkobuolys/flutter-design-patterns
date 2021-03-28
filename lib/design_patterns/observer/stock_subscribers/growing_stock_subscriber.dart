import '../stock.dart';
import '../stock_change_direction.dart';
import '../stock_subscriber.dart';

class GrowingStockSubscriber extends StockSubscriber {
  GrowingStockSubscriber() {
    title = 'Growing stocks';
  }

  @override
  void update(Stock stock) {
    if (stock.changeDirection == StockChangeDirection.growing) {
      stockStreamController.add(stock);
    }
  }
}
