import 'package:flutter/material.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  final Widget child;
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: MyColors.primaryColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                backgroundColor: MyColors.textWhite.withValues(alpha: 0.1),
              )
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(
                backgroundColor: MyColors.textWhite.withValues(alpha: 0.1),
              )
            ),  
            child,              
         ],
        ),
      ),
    );
  }
}

