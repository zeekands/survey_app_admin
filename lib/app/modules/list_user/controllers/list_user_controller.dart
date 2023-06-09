import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:survey_app_admin/app/data/models/account_model.dart';

class ListUserController extends GetxController {
  final ref = FirebaseFirestore.instance.collection('account');

  Stream<List<AccountModel>> readAccount() {
    return ref.snapshots().map(
          (list) => list.docs
              .map(
                (doc) => AccountModel.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Future<void> addAccount(
    String name,
    String email,
    String password,
    String npk,
  ) async {
    final refDoc = ref.doc();
    final account = AccountModel(
      id: refDoc.id,
      name: name,
      npk: npk,
      email: email,
      password: password,
      createdAt: DateTime.now().toString(),
    );
    await refDoc.set(account.toJson());
  }

  Future<void> updateAccount(
    String id,
    String name,
    String email,
    String password,
    String npk,
  ) async {
    final refDoc = ref.doc(id);
    final account = AccountModel(
      id: id,
      name: name,
      npk: npk,
      email: email,
      password: password,
      createdAt: DateTime.now().toString(),
    );
    await refDoc.update(account.toJson());
  }

  Future<void> deleteAccount(String id) async {
    await ref.doc(id).delete();
  }
}
