import 'package:climathon_admin/constants/colors.dart';
import 'package:climathon_admin/models/map_info_model.dart';
import 'package:climathon_admin/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class _SelectButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SelectButton({
    Key? key,
    required this.text,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;
    var subtitle = Theme.of(context).textTheme.subtitle1;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
              color: primary.withOpacity(selected ? 1.0 : 0.6),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              text,
              style: subtitle?.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class ClimathonSituationMapPage extends StatefulWidget {
  const ClimathonSituationMapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClimathonSituationMapPage> createState() =>
      _ClimathonSituationMapPageState();
}

class _ClimathonSituationMapPageState extends State<ClimathonSituationMapPage> {
  final List<List<ClimathonMapInfoModel>> __dummy__ = [
    [
      ClimathonMapInfoModel('Bezru?ova ulica', Colors.green, 20),
      ClimathonMapInfoModel('Jakubovo námestie', Colors.pink, 40),
      ClimathonMapInfoModel('Vazovova', Colors.purple, 150),
    ],
    [
      ClimathonMapInfoModel('Vajnory', Colors.green, 20),
      ClimathonMapInfoModel('Devín', Colors.pink, 40),
      ClimathonMapInfoModel('Nové Mesto', Colors.purple, 150),
    ],
    [
      ClimathonMapInfoModel('Bratislava I', Colors.green, 20),
      ClimathonMapInfoModel('Bratislava II', Colors.pink, 40),
      ClimathonMapInfoModel('Bratislava III', Colors.purple, 150),
    ]
  ];

  late List<ClimathonMapInfoModel> _data;
  late final List<MapShapeSource> _layerSource;
  int _selectedLayer = 0;

  final _primary = ClimathonColors.primary;
  final _secondary = ClimathonColors.secondary;

  bool _loading = true;

  Future<List<ClimathonMapInfoModel>> _getData() async {
    return await Future.delayed(const Duration(seconds: 1))
        .then((value) => __dummy__[_selectedLayer]);
  }

  MapShapeSource _createLayer(String asset, String shapeDataField) {
    return MapShapeSource.asset(
      'assets/$asset',
      shapeDataField: shapeDataField,
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].key,
      bubbleColorValueMapper: (int index) => _data[index].color,
      bubbleSizeMapper: (int index) => _data[index].size,
    );
  }

  _preLoadData() async {
    _loading = true;
    _data = await _getData();
    _layerSource = [
      _createLayer('ba-zsj.json', 'NAZOV_ZSJ'),
      _createLayer('ba-mc.json', 'TEXT'),
      _createLayer('ba-okr.json', 'NM3'),
    ];
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _preLoadData();
  }

  void _selectLayer(int layerIndex) {
    if (_selectedLayer != layerIndex) {
      setState(() {
        _selectedLayer = layerIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfMapsTheme(
          data: SfMapsThemeData(
            shapeHoverColor: _primary.withOpacity(0.5),
            shapeHoverStrokeColor: _primary,
            shapeHoverStrokeWidth: 2,
          ),
          child: ClimathonMap(
            subLayers: [
              if (!_loading)
                MapShapeSublayer(
                  source: _layerSource[_selectedLayer],
                  color: _secondary.withOpacity(0.2),
                  strokeWidth: 1,
                  strokeColor: _secondary,
                  bubbleSettings: const MapBubbleSettings(
                    minRadius: 5,
                    maxRadius: 20,
                  ),
                  bubbleTooltipBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 40,
                      width: 120,
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Oblasť           : ',
                                  style: TextStyle(color: Colors.white)),
                              Text(_data[index].key,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Population : ',
                                  style: TextStyle(color: Colors.white)),
                              Text(_data[index].size.toString(),
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        Positioned(
          right: 8,
          bottom: 32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SelectButton(
                text: 'Sídelné jednotky',
                selected: _selectedLayer == 0,
                onTap: () => _selectLayer(0),
              ),
              const SizedBox(height: 16),
              _SelectButton(
                text: 'Mestské časti',
                selected: _selectedLayer == 1,
                onTap: () => _selectLayer(1),
              ),
              const SizedBox(height: 16),
              _SelectButton(
                text: 'Okresy',
                selected: _selectedLayer == 2,
                onTap: () => _selectLayer(2),
              ),
            ],
          ),
        ),
        if (_loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
