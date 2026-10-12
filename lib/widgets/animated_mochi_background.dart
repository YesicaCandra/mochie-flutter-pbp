import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Latar bergerak untuk halaman Login dan Register.
// - Gradient pastel berputar pelan.
// - Bulatan dan cincin melayang naik-turun.
// - Maskot MOCHIÉ melayang pada layout lebar.
// Animasi berhenti otomatis jika pengaturan "kurangi gerakan" aktif.
class AnimatedMochiBackground extends StatefulWidget {
  final Widget child;

  const AnimatedMochiBackground({super.key, required this.child});

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

  // Satu bentuk dekoratif.
  Widget _shape({
    required double left,
    required double top,
    required double size,
    required Color color,
    required double phase,
    bool ring = false,
    double ringWidth = 6,
  }) {
    final dy = math.sin((_controller.value + phase) * 2 * math.pi) * 14;

    return Positioned(
      left: left,
      top: top + dy,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ring ? null : color,
          border: ring ? Border.all(color: color, width: ringWidth) : null,
        ),
      ),
    );
  }

  // Maskot MOCHIÉ yang melayang perlahan.
  Widget _buildMochiMascot({required double width, required double height}) {
    final mascotSize = width < 1000 ? 125.0 : 155.0;

    return Positioned(
      left: width * 0.30,
      top: height * 0.57,
      child: IgnorePointer(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final reduceMotion = MediaQuery.disableAnimationsOf(context);

              final dy = reduceMotion
                  ? 0.0
                  : math.sin(_controller.value * 2 * math.pi) * 10;

              return Transform.translate(offset: Offset(0, dy), child: child);
            },
            child: Opacity(
              opacity: 0.96,
              child: Image.asset(
                'assets/images/mochi_mascot.png',
                width: mascotSize,
                height: mascotSize,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Background tetap aman jika aset belum tersedia.
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Stack(
          children: [
            // Gradient berputar pelan + bentuk melayang.
            Positioned.fill(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          transform: GradientRotation(
                            _controller.value * 2 * math.pi,
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
                        children: [
                          _shape(
                            left: w * 0.62,
                            top: -h * 0.06,
                            size: 210,
                            color: AppTheme.yellow.withValues(alpha: 0.55),
                            phase: 0.0,
                          ),
                          _shape(
                            left: -50,
                            top: h * 0.24,
                            size: 130,
                            color: AppTheme.lavender.withValues(alpha: 0.4),
                            phase: 0.3,
                          ),
                          _shape(
                            left: w - 150,
                            top: h - 190,
                            size: 210,
                            color: AppTheme.peach.withValues(alpha: 0.4),
                            phase: 0.6,
                          ),
                          _shape(
                            left: w * 0.08,
                            top: h * 0.1,
                            size: 56,
                            color: AppTheme.primary.withValues(alpha: 0.35),
                            phase: 0.15,
                            ring: true,
                            ringWidth: 5,
                          ),
                          _shape(
                            left: w * 0.1,
                            top: h * 0.8,
                            size: 90,
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
            ),

            // Maskot hanya ditampilkan pada layout lebar.
            if (w >= 720) _buildMochiMascot(width: w, height: h),

            // Konten halaman tetap berada di atas background.
            Positioned.fill(child: widget.child),
          ],
        );
      },
    );
  }
}
