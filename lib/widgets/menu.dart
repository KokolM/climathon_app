import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClimathonMenuItem {
  final String name;
  final IconData icon;
  final Widget page;

  ClimathonMenuItem(
    this.name,
    this.icon,
    this.page,
  );
}

class _ItemProvider extends ChangeNotifier {
  int _selected = 0;

  _ItemProvider(int defaultValue) {
    _selected = defaultValue;
  }

  int get selected => _selected;

  set selected(int value) {
    if (_selected != value) {
      _selected = value;
      notifyListeners();
    }
  }
}

class _MenuButton extends StatelessWidget {
  final ClimathonMenuItem item;
  final int index;

  const _MenuButton({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  _onTap(BuildContext context) {
    context.read<_ItemProvider>().selected = index;
  }

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;
    var subtitle = Theme.of(context).textTheme.subtitle1;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
      child: Consumer<_ItemProvider>(builder: (context, provider, _) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _onTap(context),
            child: Container(
              decoration: BoxDecoration(
                  color: primary.withOpacity(
                    provider.selected == index ? 0.4 : 0.1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                child: Row(
                  children: [
                    Icon(
                      item.icon,
                      size: 24,
                      color: provider.selected == index
                          ? Colors.black54
                          : Colors.black45,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      item.name,
                      style: subtitle?.copyWith(
                          color: provider.selected == index
                              ? Colors.black
                              : Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ClimathonMenu extends StatelessWidget {
  final Widget? title;
  final List<ClimathonMenuItem> items;
  final int? defaultItemSelected;

  const ClimathonMenu({
    Key? key,
    this.title,
    required this.items,
    this.defaultItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ItemProvider(defaultItemSelected ?? 0),
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1600),
            child: Consumer<_ItemProvider>(builder: (context, provider, _) {
              return items[provider.selected].page;
            }),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 240,
              ),
              child: Column(
                children: [
                  if (title != null) title!,
                  const SizedBox(height: 64),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) => _MenuButton(
                        item: items[index],
                        index: index,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
