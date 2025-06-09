import 'package:flutter/material.dart';
import 'package:registro_prestamos/common/widgets/image_text_widget/vertical_image_text.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index){
          return VerticalImageText(
            image: AssetsManager.zapatosImage, 
            title: 'Shoes',
            onTap: (){},
          );
        },
      ),
    );
  }
}

