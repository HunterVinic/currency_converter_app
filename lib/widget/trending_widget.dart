import 'package:currency_converter_app/model/currency_info.dart';
import 'package:flutter/material.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({
    Key? key,
    required this.trendingList,
  }) : super(key: key);

  final Future<List<CurrencyInfo>> trendingList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Rates for Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FutureBuilder(
              future: trendingList,
              builder: (context, AsyncSnapshot<List<CurrencyInfo>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.all(4),
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 5,
                        columnSpacing: 5,
                        columns: [
                          DataColumn(
                            label: Container(
                              child: Row(
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 25,
                                      minWidth: 25,
                                      maxHeight: 25,
                                      maxWidth: 25,
                                    ),
                                    child: Image.asset('assets/images/usd.png'),
                                  ),
                                  SizedBox(width: 9),
                                  Text(
                                    'US Dollar',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Latest Rate',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Change',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Change %',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        rows: snapshot.data!.map((d) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: 20,
                                          minWidth: 20,
                                          maxHeight: 20,
                                          maxWidth: 20,
                                        ),
                                        child: Image.asset('assets/images/${d.currency}.png'.toLowerCase()),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '${d.currency}/USD',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${d.marketPrice!.fmt}',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${d.marketChange!.fmt}',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${d.marketChangePercent!.fmt}',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('Error loading data.'),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
