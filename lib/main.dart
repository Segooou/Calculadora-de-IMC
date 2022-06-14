import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home() ,  debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String infotext = "Informe seus dados!"; 
  void resetfields(){
    weightController.text = "";
    heightController.text ="";
    setState((){
      infotext = "Informe seus dados!";
      formkey = GlobalKey<FormState>();
    });



  }


  void calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight / (height * height);
      print(imc);
      if (imc <= 18.6) {
        infotext = "Abaixo do Peso(${imc.toStringAsPrecision(4)})";
      }else if (imc >= 18.6 && imc < 24.9){
        infotext = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      }else if (imc >= 24.9 && imc < 29.9) {
        infotext = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      }else if (imc >= 29.9 && imc < 34.9) {
        infotext = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      }else if (imc >= 34.9 && imc < 39.9) {
      infotext = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
    }else if (imc >= 40) {
  infotext = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
  }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true ,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
    onPressed:resetfields,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline,size: 120,color: Colors.blueAccent,),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.blueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent,fontSize: 25),
                controller: weightController,
                validator: (value){
                if(value!.isEmpty){
                  return "Insisira Seu Peso";
                }

                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Altura (CM)",
                    labelStyle: TextStyle(color: Colors.blueAccent)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent,fontSize: 25),
                controller: heightController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insisira Sua Altura";
                    }}
              ),
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Container(
                  height: 50,

                  child: RaisedButton(onPressed:(){
                    if (formkey.currentState!.validate()){
                      calculate();
                    }
                  },
                    child:Text("Calcular",style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center,),
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Text(infotext,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25),)
            ],
          ),
        ),
      )

    );
  }
}
