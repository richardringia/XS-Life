import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xs_life/src/constants/collection_constants.dart';
import 'package:xs_life/src/features/map/data/map_repository_interface.dart';
import 'package:xs_life/src/features/map/domain/map_category.dart';
import 'package:xs_life/src/features/map/domain/map_item.dart';

class MapRepository extends IMapRepository {
  CollectionReference<Map<String, dynamic>> mapCollection = FirebaseFirestore
      .instance.collection(CollectionConstants.map);
  CollectionReference<
      Map<String, dynamic>> mapCategoryCollection = FirebaseFirestore
      .instance.collection(CollectionConstants.mapCategory);

  @override
  Future<List<MapCategory>> getCategories() async {
    await checkAuth();
    List<MapCategory> map = [];

    mapCategoryCollection.get().then((value) => {

    });

    return map;
  }

  @override
  Future<MapCategory> getCategory(String id) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<MapItem> getMapItem(String id) {
    // TODO: implement getMapItem
    throw UnimplementedError();
  }

  @override
  Future<List<MapItem>> getMapItems() {
    // TODO: implement getMapItems
    throw UnimplementedError();
  }

}