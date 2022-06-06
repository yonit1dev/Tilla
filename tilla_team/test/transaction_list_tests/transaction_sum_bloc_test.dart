import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tilla_team/application/transactions/transaction_sum/transaction_sum_bloc.dart';
import 'package:tilla_team/services/transaction_service.dart/repo/transaction_repo.dart';

import 'transaction_list_test.mocks.dart';

@GenerateMocks([TransactionRepo])
void main() {
  late MockTransactionRepo mockTransactionRepo;

  setUp(() {
    mockTransactionRepo = MockTransactionRepo();
  });

  group("TransactionSumBloc", () {
    test(
        'Emits states accordingly -> TransactionInitial -> TransactionSumDone when transaction sum aggregated successfuly',
        () async {
      final transactionBloc = TransactionSumBloc(mockTransactionRepo);

      final response = mockTransactionRepo.sumTransactions();

      transactionBloc.add(TransactionSumReq());

      expectLater(
        transactionBloc.stream,
        emitsInOrder(
          [TransactionSumInital, TransactionSumDone(response as List)],
        ),
      );
    });
  });
}
