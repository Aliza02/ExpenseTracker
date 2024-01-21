// enum TransactionTileColorEvents {
//   transactionTileHomeScreenEvent,
//   transactionTileInAllTransactionEvent
// }

abstract class TransactionTileColorEvents {}

class TransactionTileHomeScreenEvent extends TransactionTileColorEvents {}

class TransactionTileAllTransactionEvent extends TransactionTileColorEvents {}
