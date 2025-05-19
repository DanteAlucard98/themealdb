import 'package:flutter/material.dart';
import 'package:recetas_adpp_2025/main.dart';

//Tarjeta expandible
class ExpandableCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;
  final List<Color> gradientColors;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;

  //Constructor de la tarjeta expandible
  const ExpandableCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.children,
    required this.gradientColors,
    required this.gradientBegin,
    required this.gradientEnd,
  }) : super(key: key);

  //Crear el estado de la tarjeta expandible
  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

//Estado de la tarjeta expandible
class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;

  //Construir el widget de la tarjeta expandible
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: widget.gradientBegin,
          end: widget.gradientEnd,
          colors: widget.gradientColors,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                children: [
                  Icon(widget.icon, color: widget.iconColor),
                  const SizedBox(width: 8),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.textPrimary.withOpacity(0.6),
                  ),
                ],
              ),
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 8),
              ...widget.children,
            ],
          ],
        ),
      ),
    );
  }
}
