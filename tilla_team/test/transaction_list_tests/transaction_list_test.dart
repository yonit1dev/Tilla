import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tilla_team/application/transactions/transaction_multiple/transaction_list_bloc.dart';
import 'package:tilla_team/services/services.dart';

import 'transaction_list_test.mocks.dart';

@GenerateMocks([TransactionRepo])
void main() {
  late MockTransactionRepo mockTransactionRepo;

  setUp(() {
    mockTransactionRepo = MockTransactionRepo();
  });

  group("TransactionListView", () {
    test(
        'Emits states accordingly -> TransactionInitial -> TransactionLoading -> TransactionStateSuccess when loaded successfuly',
        () async {
      final transactionBloc = TransactionListBloc(mockTransactionRepo);

      final response = mockTransactionRepo.getAllTransactions();

      transactionBloc.add(TransactionListEventLoaded());

      expectLater(
        transactionBloc.stream,
        emitsInOrder(
          [
            TransactionListStateInitial(),
            TransactionListStateLoading(),
            TransactionListStateSuccess(response as List)
          ],
        ),
      );
    });
  });
}
