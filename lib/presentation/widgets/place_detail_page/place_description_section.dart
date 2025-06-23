import 'package:flutter/material.dart';

class PlaceDescriptionSection extends StatefulWidget {
  final String description;

  const PlaceDescriptionSection({super.key, required this.description});

  @override
  State<PlaceDescriptionSection> createState() =>
      _PlaceDescriptionSectionState();
}

class _PlaceDescriptionSectionState extends State<PlaceDescriptionSection> {
  bool showFullDescription = false;
  static const descriptionMaxLines = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final span = TextSpan(
              text: widget.description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff848997),
                height: 1.7,
              ),
            );
            final tp = TextPainter(
              text: span,
              maxLines: descriptionMaxLines,
              textDirection: TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth);

            final isOverflowing = tp.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 200),
                  crossFadeState:
                      showFullDescription
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                  firstChild: Container(
                    constraints: const BoxConstraints(),
                    child: ShaderMask(
                      shaderCallback:
                          (bounds) => const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ).createShader(bounds),
                      blendMode: BlendMode.dstIn,
                      child: Text(
                        widget.description,
                        maxLines: descriptionMaxLines,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff848997),
                          height: 1.7,
                        ),
                      ),
                    ),
                  ),
                  secondChild: Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff848997),
                      height: 1.7,
                    ),
                  ),
                ),
                if (isOverflowing)
                  OutlinedButton(
                    onPressed:
                        () => setState(() {
                          showFullDescription = !showFullDescription;
                        }),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFFF7043)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          showFullDescription ? "Show less" : "Show more",
                          style: const TextStyle(color: Color(0xFFFF7043)),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          showFullDescription
                              ? Icons.expand_less
                              : Icons.expand_more,
                          color: const Color(0xFFFF7043),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
