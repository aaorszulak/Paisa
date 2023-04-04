import 'package:flutter/material.dart';

import '../../../core/common.dart';
import '../../../domain/category/entities/category.dart';
import '../../widgets/paisa_bottom_sheet.dart';
import '../bloc/category_bloc.dart';
import '../widgets/category_item_tablet_widget.dart';

class CategoryListTabletWidget extends StatelessWidget {
  const CategoryListTabletWidget({
    Key? key,
    required this.addCategoryBloc,
    this.crossAxisCount = 1,
    required this.categories,
  }) : super(key: key);

  final CategoryBloc addCategoryBloc;
  final int crossAxisCount;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        bottom: 124,
        left: 8,
        right: 8,
        top: 8,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      itemCount: categories.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return CategoryItemTabletWidget(
          category: categories[index],
          onPressed: () => paisaAlertDialog(
            context,
            title: Text(context.loc.dialogDeleteTitleLabel),
            child: RichText(
              text: TextSpan(
                text: context.loc.deleteCategoryLabel,
                children: [
                  TextSpan(
                      text: categories[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            confirmationButton: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () {
                addCategoryBloc.add(CategoryDeleteEvent(categories[index]));
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ),
        );
      },
    );
  }
}
