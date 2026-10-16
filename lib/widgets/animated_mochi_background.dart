import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Background pastel animasi untuk Login dan Register.
// Posisi maskot menyesuaikan ukuran layar dan tidak menutupi form.
class AnimatedMochiBackground extends StatefulWidget {
  final Widget child;

  // Maskot bisa dimatikan per halaman jika diperlukan.
  final bool showMascots;

  const AnimatedMochiBackground({
    super.key,
    required this.child,
    this.showMascots = true,
  });

  @override
  State<AnimatedMochiBackground> createState() =>
      _AnimatedMochiBackgroundState();
}

class _AnimatedMochiBackgroundState extends State<AnimatedMochiBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _shape({
    required double left,
    required double top,
    required double size,
    required Color color,
    required double phase,
    bool ring = false,
    double ringWidth = 6,
  }) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final dy = reduceMotion
        ? 0.0
        : math.sin((_controller.value + phase) * 2 * math.pi) * 12;

    return Positioned(
      left: left,
      top: top + dy,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ring ? null : color,
            border: ring ? Border.all(color: color, width: ringWidth) : null,
          ),
        ),
      ),
    );
  }

  Widget _mascot({
    required String path,
    required double left,
    required double top,
    required double size,
    required double phase,
    double rotationAmount = 0.025,
  }) {
    // Gambar dimuat sesuai ukuran tampil agar hemat memori.
    final cacheWidth = (size * MediaQuery.devicePixelRatioOf(context)).round();

    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            child: Image.asset(
              path,
              width: size,
              height: size,
              fit: BoxFit.contain,
              cacheWidth: cacheWidth,
              excludeFromSemantics: true,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
            builder: (context, child) {
              final reduceMotion = MediaQuery.disableAnimationsOf(context);

              final progress = (_controller.value + phase) * 2 * math.pi;

              final dy = reduceMotion ? 0.0 : math.sin(progress) * 9;

              final rotation = reduceMotion
                  ? 0.0
                  : math.sin(progress) * rotationAmount;

              return Transform.translate(
                offset: Offset(0, dy),
                child: Transform.rotate(angle: rotation, child: child),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        final isWide = width >= 720;
        final isLarge = width >= 1100;

        // Maskot hanya tampil di layar lebar dan cukup tinggi.
        final canShowMascots = widget.showMascots && isWide && height >= 480;

        // Ukuran maskot dibatasi oleh tinggi layar agar tidak menutupi teks.
        final strawberrySize = math.min(isLarge ? 285.0 : 195.0, height * 0.34);
        final matchaSize = math.min(isLarge ? 145.0 : 100.0, height * 0.2);
        final chocolateSize = math.min(isLarge ? 145.0 : 100.0, height * 0.2);

        // Strawberry dan cokelat dipasang dari tepi bawah supaya
        // tidak keluar layar.
        final strawberryLeft = width * (isLarge ? 0.285 : 0.275);
        final strawberryTop = height - strawberrySize - (height * 0.06);

        final matchaLeft = width * (isLarge ? 0.235 : 0.215);
        final matchaTop = height * (isLarge ? 0.235 : 0.28);

        final chocolateLeft = width * (isLarge ? 0.47 : 0.455);
        final chocolateTop = height - chocolateSize - (height * 0.1);

        return Stack(
          fit: StackFit.expand,
          children: [
            // BACKGROUND GRADIENT DAN DEKORASI
            RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final reduceMotion = MediaQuery.disableAnimationsOf(context);

                  return DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        transform: GradientRotation(
                          reduceMotion ? 0 : _controller.value * 2 * math.pi,
                        ),
                        colors: const [
                          AppTheme.softPink,
                          Color(0xFFFFE3D2),
                          AppTheme.lavenderSoft,
                          AppTheme.softPink,
                        ],
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        _shape(
                          left: width * 0.62,
                          top: -height * 0.06,
                          size: isLarge ? 285 : 210,
                          color: AppTheme.yellow.withValues(alpha: 0.55),
                          phase: 0,
                        ),
                        _shape(
                          left: -50,
                          top: height * 0.24,
                          size: isLarge ? 150 : 130,
                          color: AppTheme.lavender.withValues(alpha: 0.4),
                          phase: 0.3,
                        ),
                        _shape(
                          left: width - (isLarge ? 215 : 150),
                          top: height - (isLarge ? 220 : 190),
                          size: isLarge ? 285 : 210,
                          color: AppTheme.peach.withValues(alpha: 0.4),
                          phase: 0.6,
                        ),
                        _shape(
                          left: width * 0.08,
                          top: height * 0.1,
                          size: isLarge ? 80 : 56,
                          color: AppTheme.primary.withValues(alpha: 0.35),
                          phase: 0.15,
                          ring: true,
                          ringWidth: 5,
                        ),
                        _shape(
                          left: width * 0.1,
                          top: height * 0.8,
                          size: isLarge ? 115 : 90,
                          color: AppTheme.lavender.withValues(alpha: 0.5),
                          phase: 0.75,
                          ring: true,
                          ringWidth: 7,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // MASKOT HANYA DI LAYAR LEBAR.
            // Pada layar ponsel, background tetap sederhana.
            if (canShowMascots) ...[
              _mascot(
                path: 'assets/images/mochi_matcha.png',
                left: matchaLeft,
                top: matchaTop,
                size: matchaSize,
                phase: 0.30,
                rotationAmount: 0.035,
              ),
              _mascot(
                path: 'assets/images/mochi_mascot.png',
                left: strawberryLeft,
                top: strawberryTop,
                size: strawberrySize,
                phase: 0,
                rotationAmount: 0.018,
              ),
              _mascot(
                path: 'assets/images/mochi_chocolate.png',
                left: chocolateLeft,
                top: chocolateTop,
                size: chocolateSize,
                phase: 0.65,
                rotationAmount: 0.035,
              ),
            ],

            // Konten Login/Register tetap paling depan.
            Positioned.fill(child: widget.child),
          ],
        );
      },
    );
  }
}
