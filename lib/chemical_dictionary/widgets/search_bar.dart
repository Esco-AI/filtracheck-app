import 'package:flutter/material.dart';
import 'frosted.dart';

class FrostedSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onClear;

  const FrostedSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onClear,
  });

  @override
  State<FrostedSearchBar> createState() => _FrostedSearchBarState();
}

class _FrostedSearchBarState extends State<FrostedSearchBar> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (mounted) setState(() => _focused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Frosted(
        borderRadius: 16,
        blur: 16,
        tint: Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: _focused
              ? Colors.white.withValues(alpha: 0.45)
              : Colors.white.withValues(alpha: 0.18),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.search_rounded, color: Colors.white70),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Search by name, CAS, or formula',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            if (widget.controller.text.isNotEmpty)
              IconButton(
                onPressed: widget.onClear,
                splashRadius: 18,
                icon: const Icon(Icons.close_rounded, color: Colors.white70),
              ),
          ],
        ),
      ),
    );
  }
}
