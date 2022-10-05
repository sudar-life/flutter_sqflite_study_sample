import 'package:flutter/material.dart';
import 'package:flutter_sqflite_study_sample/model/sample.dart';
import 'package:flutter_sqflite_study_sample/repository/sql_sample_crud_repository.dart';
import 'package:flutter_sqflite_study_sample/utils/data.dart';

class DetailView extends StatefulWidget {
  final Sample sample;
  const DetailView({Key? key, required this.sample}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  Future<Sample?> _loadSampleOne() async {
    return await SqlSampleCrudRepository.getOne(widget.sample.id!);
  }

  void update(Sample sample) async {
    double value = DataUtils.randomValue();
    var updateSample = sample.clone(yn: value.toInt() % 2 == 0, value: value);
    var result = await SqlSampleCrudRepository.update(updateSample);
    print(result);
    setState(() {});
  }

  void delete(Sample sample) async {
    var result = await SqlSampleCrudRepository.delete(sample.id!);
    print(result);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.sample.id.toString(),
          ),
        ),
        body: FutureBuilder(
          future: _loadSampleOne(),
          builder: (context, AsyncSnapshot<Sample?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Not Found Data By ${widget.sample.id}.'),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'name : ${snapshot.data?.name}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Y/N : ${snapshot.data?.yn}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Value : ${snapshot.data?.value}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'CreatedAt : ${snapshot.data?.createdAt}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        update(snapshot.data!);
                      },
                      child: const Text('업데이트 랜덤 값'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        delete(snapshot.data!);
                      },
                      child: const Text('삭제'),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
