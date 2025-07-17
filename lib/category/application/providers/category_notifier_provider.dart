import 'package:app/category/application/category_notifier.dart';
import 'package:app/category/application/category_state.dart';
import 'package:app/category/application/providers/category_repository_provider.dart';
import 'package:app/category/domain/usecase/add_category_use_case.dart';
import 'package:app/category/domain/usecase/category_all_catetories_use_case.dart';
import 'package:app/category/domain/usecase/delete_category_usc_case.dart';
import 'package:app/category/domain/usecase/update_category_usc_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);

  return CategoryNotifier(
    getAllCategoriesUseCase: GetAllCategoriesUseCase(repository),
    addCategoryUseCase: AddCategoryUseCase(repository),
    deleteCategoryUscCase: DeleteCategoryUscCase(repository),
    updateCategoryUscCase: UpdateCategoryUscCase(repository),
  );
});
