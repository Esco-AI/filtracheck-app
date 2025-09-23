import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../models/chemical.dart';
import 'package:filtracheck_v2/calculator/widgets/read_only_info_row.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class GlassField extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  const GlassField({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  const GlassTextField({
    super.key,
    required this.controller,
    required this.label,
    this.prefixIcon,
    this.validator,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true),
  });

  @override
  Widget build(BuildContext context) {
    return GlassField(
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white.withValues(alpha: 0.9))
              : null,
          labelStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontWeight: FontWeight.w700,
          ),
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

class GlassDropdownChemical extends StatelessWidget {
  final List<Chemical> items;
  final Chemical? selected;
  final bool enabled;
  final FormFieldValidator<Chemical>? validator;
  final ValueChanged<Chemical?> onChanged;

  const GlassDropdownChemical({
    super.key,
    required this.items,
    required this.selected,
    required this.onChanged,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return GlassField(
      child: DropdownSearch<Chemical>(
        items: items,
        itemAsString: (u) => u.name,
        onChanged: onChanged,
        selectedItem: selected,
        validator: validator,
        enabled: enabled,
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: 'Search Chemical',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.75)),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              isDense: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
          itemBuilder: (context, chemical, isSelected) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFF3AADEA), Color(0xFF0D7AC8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : Colors.white.withValues(alpha: 0.06),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: ListTile(
                dense: true,
                title: Text(
                  chemical.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Colors.white)
                    : null,
              ),
            );
          },
          menuProps: MenuProps(
            backgroundColor: Color.fromARGB(255, 27, 114, 168),
            borderRadius: BorderRadius.circular(16),
            elevation: 0,
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          dropdownSearchDecoration: InputDecoration(
            labelText: 'Choose chemical',
            prefixIcon: Icon(
              Icons.science_rounded,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            labelStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontWeight: FontWeight.w700,
            ),
            isDense: true,
            filled: false,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        dropdownButtonProps: const DropdownButtonProps(
          color: Colors.white,
          icon: Icon(Icons.expand_more_rounded, color: Colors.white),
        ),
      ),
    );
  }
}

class CalculatedPanel extends StatelessWidget {
  final String density;
  final String filterType;
  const CalculatedPanel({
    super.key,
    required this.density,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context) {
    return GlassField(
      padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
      child: Column(
        children: [
          ReadOnlyInfoRow(label: 'Density', value: density),
          const ReadOnlyInfoRow(label: '%Capacity', value: '0.00'),
          const ReadOnlyInfoRow(label: 'Mass Evaporated/month', value: '0.00'),
          ReadOnlyInfoRow(label: 'Type of Filter', value: filterType),
        ],
      ),
    );
  }
}
