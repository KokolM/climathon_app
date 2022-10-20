import 'package:climathon_admin/models/data.dart';
import 'package:flutter/material.dart';

class ClimathonSituationMapDataTooltip extends StatelessWidget {
  final ClimathonDataModel data;

  const ClimathonSituationMapDataTooltip({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Center(
                child: Text(
                  data.key,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                  ),
                ),
              ),
              const Icon(
                Icons.map,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
          const Divider(
            color: Colors.white,
            height: 10,
            thickness: 1.2,
          ),
          Text(
            'Size : ${data.size}',
            style: TextStyle(
              color: Colors.white,
              fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
