import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora - Tarea 1',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculadora - Tarea 1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

   String texto1='0.01', texto2='0.01';


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color:  Color.fromRGBO(171, 206, 147, 1),

        ),
        Positioned(
            top:245, left: 0,right: 25,
            child:Text(texto1.toString(),textAlign: TextAlign.right,style: TextStyle(color: Color.fromRGBO(43, 118, 0, 1),fontSize: 16),            )
        ),
        Positioned(
        top:275, left: 0,right: 25,
        child:Text(
          texto2.toString() ,textAlign: TextAlign.right, style: TextStyle(color: Color.fromRGBO(43, 118, 0, 1),fontSize: 20),)
    ),
        Positioned(
          bottom:0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            child:Container(
               width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.55,

              color:Color.fromRGBO(249, 251, 251, 0.75) ,
            ),
          ),
        ),
        Positioned(
          top: 350, bottom: 0,left: 10,right: 10,
            child:botones()
        )

      ],
    );


  }

  Widget botones (){
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          boton('C', true),
          boton('+/-', true),
          boton('%', true),
          boton('/', true),
          //            botones()
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          boton('7', false),
          boton('8', false),
          boton('9', false),
          boton('x', true),
          //            botones()
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          boton('4', false),
          boton('5', false),
          boton('6', false),
          boton('-', true),
          //            botones()
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          boton('1', false),
          boton('2', false),
          boton('3', false),
          boton('+', true),
          //            botones()
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          boton('0', false),
          boton(' ', false),
          boton('.', false),
          boton('=', true),
          //            botones()
        ],
      ),

    ],
  );

  }

  Widget boton (String texto, bool pintado){
    Color _bColor =  Color.fromRGBO(171, 206, 147, 1);
    Color _tColor =  Colors.white;
    String valor;
    valor=texto;
    if (!pintado) {
      _bColor=null;
      _tColor =Color.fromRGBO(43, 118, 0, 1);
    }
    if(texto=='x')valor='*';
    return
     MaterialButton(
          onPressed: () {
            calcular(valor,pintado);
          },
          color: _bColor,
          child: Text(texto,style: TextStyle(color: _tColor,fontSize: 25)) ,
        );



  }

  void calcular(String texto,bool pintado){
    
    Parser _parser = Parser();
    Expression exp;

    switch(texto) {
      case "C": {
      setState(() {
        texto1='0';texto2='0';
      });

      // statements;
    }
    break;
      case "+/-": {
        setState(() {

          texto2='('+texto2.toString()+')*-1';
          exp = _parser.parse(texto2);
         // texto1=texto2;
          texto2 = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
        });

        // statements;
      }
      break;
      case '=': {

        setState(() {
           exp = _parser.parse(texto2);
          texto1=texto2;
          texto2 = exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
        });

      }
      break;

      case '.': {
        //si no encontramos el punto en el texto
        if (texto2.indexOf('.')==-1){
          setState(() {
            texto2=texto2+'.';
          });
        }
        //statements;
      }
      break;
      default: {
        String x;
        if( texto2=='0' ){
          x=texto.toString();

        }else{
          x=texto2+texto.toString();
        }
        setState(() {
          texto2=x;
        });
        //si no fue ninguno de los anteriores, entonces son numeros
      }
      break;
    }


  }

}