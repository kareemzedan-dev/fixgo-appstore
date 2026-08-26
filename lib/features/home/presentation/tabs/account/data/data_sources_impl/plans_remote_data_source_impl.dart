import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../data_sources/plans_remote_data_source.dart';
import '../models/plan.dart';

@Injectable(as: PlansRemoteDataSource)
class PlansRemoteDataSourceImpl implements PlansRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Plan>> getPlans() async {
    final snapshot = await _firestore
        .collection('plans')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Plan.fromMap(doc.data(), doc.id))
        .toList();
  }
}
