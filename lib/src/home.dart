import 'package:flutter/material.dart';
import 'package:flutter_sqflite_study_sample/model/sample.dart';
import 'package:flutter_sqflite_study_sample/repository/sql_sample_crud_repository.dart';
import 'package:flutter_sqflite_study_sample/src/detail_view.dart';
import 'package:flutter_sqflite_study_sample/utils/data.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Sample>> _loadSampleList() async {
    return await SqlSampleCrudRepository.getList();
  }

  void createRandomSample() async {
    double value = DataUtils.randomValue();
    var sample = Sample(
        name: DataUtils.makeUUID(),
        yn: value.toInt() % 2 == 0,
        value: value,
        createdAt: DateTime.now());
    await SqlSampleCrudRepository.create(sample);
    update();
  }

  void update() => setState(() {});

  Widget _sampleOne(Sample sample) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(
              sample: sample,
            ),
          ),
        );
        update();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sample.yn ? Colors.green : Colors.red,
                  ),
                ),
                Text(
                  sample.name,
                  style: const TextStyle(fontSize: 17),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              sample.createdAt.toIso8601String(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqflite Sample'),
      ),
      body: FutureBuilder(
        future: _loadSampleList(),
        builder: (context, AsyncSnapshot<List<Sample>> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Not Support Sqflite.'));
          }
          if (snapshot.hasData) {
            var datas = snapshot.data;
            return ListView(
              children: List.generate(
                  datas!.length, (index) => _sampleOne(datas[index])).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createRandomSample,
        child: const Icon(Icons.add),
      ),
    );
  }
}
