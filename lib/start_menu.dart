import 'package:flutter/material.dart';
import 'core/game.dart';

class StartMenu extends StatelessWidget {
  final FlappyGame game;
  const StartMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {},
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.16,
                    left: 24,
                    right: 24,
                    child: Column(
                      children: [
                        Text(
                          'FLAPPY FLAME',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF224D55),
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: Color(0x99FFFFFF),
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A little bird. A big adventure.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF315F68),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.64,
                    left: 48,
                    right: 48,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 230,
                          height: 58,
                          child: ElevatedButton.icon(
                            onPressed: game.startGame,
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 30,
                            ),
                            label: const Text(
                              'START',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF224D55),
                              backgroundColor: const Color(0xFFFFD16A),
                              elevation: 5,
                              shadowColor: const Color(0x66315F68),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tap to flap • Fly through the gaps',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF224D55),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
