import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:fixgo/features/view_packages/data/data_sources/remote/boost_package_remote_data_source.dart';
import 'package:fixgo/features/view_packages/data/models/boost_package_model.dart';

@Injectable(as: BoostPackageRemoteDataSource)
class BoostPackageRemoteDataSourceImpl implements BoostPackageRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _collection =>
      _firestore.collection('boost_packages');

  @override
  Future<List<BoostPackageModel>> getPackages() async {
    final snapshot = await _collection.get();

    return snapshot.docs
        .map(
          (doc) => BoostPackageModel.fromJson({
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          }),
        )
        .toList();
  }

  @override
  Future<void> addPackage(BoostPackageModel model) async {
    final doc = _collection.doc();

    await doc.set(model.copyWith(id: doc.id).toJsonWithoutId());
  }

  @override
  Future<void> updatePackage(BoostPackageModel model) async {
    await _collection.doc(model.id).update(model.toJsonWithoutId());
  }

  @override
  Future<void> deletePackage(String id) async {
    await _collection.doc(id).delete();
  }

  @override
  Future<void> togglePackage(String id, bool isActive) async {
    await _collection.doc(id).update({'is_active': isActive});
  }
}
