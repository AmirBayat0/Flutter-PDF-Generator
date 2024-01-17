class BillModel {
  final String customer;
  final String address;
  final String name;
  final List<LineItem> items;
  BillModel({
    required this.customer,
    required this.address,
    required this.items,
    required this.name,
  });
  double totalCost() {
    return items.fold(
        0, (previousValue, element) => previousValue + element.cost);
  }
}

class LineItem {
  final String description;
  final double cost;

  LineItem(this.description, this.cost);
}
