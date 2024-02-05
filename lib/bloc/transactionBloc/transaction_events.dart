abstract class TransactionEvents {}

class AddTransactionEvent extends TransactionEvents {
  String amount;
  String date;
  String notes;
  AddTransactionEvent(
      {required this.amount, required this.date, required this.notes});
}
