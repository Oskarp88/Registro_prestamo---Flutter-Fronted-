import 'package:flutter/material.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  State<Init> createState() => _InitState();
}

class _InitState extends State<Init> with SingleTickerProviderStateMixin {
  late AnimationController _dotsController;
  late Animation<int> _dotsAnimation;

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _dotsAnimation = StepTween(begin: 0, end: 3).animate(_dotsController);
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0B1E2D) : const Color(0xFFEFF3F6);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo con animación de entrada
            AnimatedScale(
              scale: 1.0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              child: Image.asset(
                AssetsManager.clashcycle,
                width: 130,
              ),
            ),
            const SizedBox(height: 30),

            // Indicador de carga circular personalizado
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? Colors.white : Colors.black,
              ),
              strokeWidth: 3.5,
            ),
            const SizedBox(height: 20),

            // Texto "Cargando..." con puntos animados
            AnimatedBuilder(
              animation: _dotsController,
              builder: (_, __) {
                final dots = '.' * _dotsAnimation.value;
                return Text(
                  'Cargando CashCycle$dots',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
