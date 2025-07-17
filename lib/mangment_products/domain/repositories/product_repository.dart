import 'package:app/mangment_products/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts(
      {String? shopId, String? categoryName});
  // Future<List<ProductEntity>> fetchProductsByCategory(String categoryId);

  Future<ProductEntity> getProductById(String id);
  Future<void> addProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
}
