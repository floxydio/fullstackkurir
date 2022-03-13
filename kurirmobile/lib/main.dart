import 'package:cobabloc/Service/Models/kurir_model.dart';
import 'package:cobabloc/Service/service_http.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuKurir(),
    ));

class MenuKurir extends StatefulWidget {
  const MenuKurir({Key? key}) : super(key: key);

  @override
  State<MenuKurir> createState() => _MenuKurirState();
}

class _MenuKurirState extends State<MenuKurir> {
  List<KurirData> kurirList = [];
  String? namaBarang;
  String? dari;
  String? ke;
  String? ekspedisi;
  String? harga;

  String? dropdownValue = "Kurir Ke Tempat";
  String? hasilDropdown = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getHistoryKurir().then((value) => {
          setState(() {
            value?.data?.forEach((e) {
              kurirList.add(KurirData(
                  id: e.id,
                  namabarang: e.namabarang,
                  dari: e.dari,
                  ekspedisi: e.ekspedisi,
                  ke: e.ke,
                  harga: e.harga,
                  status: e.status));
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text("Refresh")),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          content: Column(
                            children: [
                              RegisterInput(
                                onChange: (v) {
                                  setState(() {
                                    namaBarang = v;
                                  });
                                },
                                textInput: "Nama Barang",
                              ),
                              RegisterInput(
                                onChange: (v) {
                                  setState(() {
                                    dari = v;
                                  });
                                },
                                textInput: "Dari",
                              ),
                              RegisterInput(
                                onChange: (v) {
                                  setState(() {
                                    ke = v;
                                  });
                                },
                                textInput: "Ke",
                              ),
                              RegisterInput(
                                onChange: (v) {
                                  setState(() {
                                    harga = v;
                                  });
                                },
                                textInput: "Harga",
                              ),
                              RegisterInput(
                                onChange: (v) {
                                  ekspedisi = v;
                                },
                                textInput: "Ekspedisi",
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    var kurirModel = KurirData(
                                      dari: dari,
                                      ekspedisi: ekspedisi,
                                      ke: ke,
                                      namabarang: namaBarang,
                                      status: 0,
                                      harga: int.parse(harga!),
                                    );

                                    ApiService().createHistory(kurirModel);
                                  },
                                  child: Text("Submit"))
                            ],
                          ),
                        ));
              },
              child: Text("Create")),
          ListView.builder(
              shrinkWrap: true,
              itemCount: kurirList.length,
              physics: ScrollPhysics(),
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(kurirList[i].namabarang.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dari -> ${kurirList[i].dari}"),
                      Text(kurirList[i].status == 0
                          ? "Kurir ke Tempat"
                          : kurirList[i].status == 1
                              ? "Kurir menuju ke tujuan"
                              : "Sampai")
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                content: Column(
                                  children: [
                                    DropdownButton<String>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                          setState(() {
                                            dropdownValue == "Kurir Ke Tempat"
                                                ? setState(() {
                                                    hasilDropdown = "0";
                                                  })
                                                : dropdownValue ==
                                                        "Kurir Menuju Ke Tujuan"
                                                    ? setState(() {
                                                        hasilDropdown = "1";
                                                      })
                                                    : setState(() {
                                                        hasilDropdown = "2";
                                                      });
                                          });
                                        });
                                      },
                                      items: <String>[
                                        "Kurir Ke Tempat",
                                        "Kurir Menuju Ke Tujuan",
                                        "Sampai"
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          var dataKurirEdit = KurirData(
                                              status:
                                                  int.parse(hasilDropdown!));

                                          ApiService().editKurir(
                                              dataKurirEdit, kurirList[i].id);
                                        },
                                        child: Text("update status"))
                                  ],
                                ),
                              ));
                    },
                    child: Icon(Icons.edit),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class RegisterInput extends StatelessWidget {
  final String? textInput;
  final void Function(String) onChange;
  const RegisterInput(
      {Key? key, required this.textInput, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: textInput,
      ),
    );
  }
}
