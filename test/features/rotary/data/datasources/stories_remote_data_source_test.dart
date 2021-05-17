// @dart=2.9
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rotary_nl_rye/features/stories/data/datasources/different.dart';

class MockFirebaseDatabase extends Mock implements FirebaseDatabase {}

void main() {
  StoriesRemoteDataSourceImpl dataSource;
  MockFirebaseDatabase mockFirebaseDatabase;

  setUp(() {
    dataSource = StoriesRemoteDataSourceImpl(
      firebaseDatabase: mockFirebaseDatabase
    );
  });

  // TODO write tests https://www.youtube.com/watch?v=msGsYPtZnhU&list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech&index=9
}