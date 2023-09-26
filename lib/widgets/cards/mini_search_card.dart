import 'package:brunohsp_app/widgets/cards/default_card.dart';
import 'package:flutter/material.dart';

class MiniSearchCard extends DefaultCard {
  final String domain;
  final String subdomain;
  final String url;
  final DateTime date;

  MiniSearchCard(
      {required columns,
      required this.domain,
      required this.subdomain,
      required this.url,
      required this.date,
      Key? key})
      : super(
            key: key,
            columns: columns,
            child: _MiniSearchCardChildren(
                domain: domain, subdomain: subdomain, url: url, date: date));
}

class _MiniSearchCardChildren extends StatelessWidget {
  final String domain;
  final String subdomain;
  final String url;
  final DateTime date;
  const _MiniSearchCardChildren(
      {required this.domain,
      required this.subdomain,
      required this.url,
      required this.date,
      Key? key})
      : super(key: key);

  headerBuilder() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Text(
                    domain,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(subdomain, style: const TextStyle(fontSize: 12)),
                    Text('${date.day}/${date.month}/${date.year}', style: const TextStyle(fontSize: 12))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        headerBuilder(),
      ],
    );
  }
}
