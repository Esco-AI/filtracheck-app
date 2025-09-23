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
        tint: Colors.grey.shade100,
        border: Border.all(
          color: _focused
              ? Colors.blue
              : Colors.grey.shade300,
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(
              Icons.search_rounded,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: 'Search by name, CAS, or formula',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            if (widget.controller.text.isNotEmpty)
              IconButton(
                onPressed: widget.onClear,
                splashRadius: 18,
                icon: Icon(Icons.close_rounded, color: Colors.grey.shade600),
              ),
          ],
        ),
      ),
    );
  }
}
