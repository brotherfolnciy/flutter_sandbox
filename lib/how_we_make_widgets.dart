//
//
// Виджеты более 200 строк обязательно должны быть разделены на более мелкие виджеты.
//
//

//
//
// При верстке экранов большое внимание уделяется аккуратному
// виду дереву виджетов, после каждого виджета и каждого аргумента
// обязательно проставлять запятую, кроме случаев, когда виджет прям маленький.
//
//

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_flutter_reglament/other/bloc/example_bloc.dart';

class WebAntExampleWidget extends StatelessWidget {
  const WebAntExampleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Title',
        ),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}

//
//
// Внутри дерева виджетов можно расписывать функции состоящие из не более
// 3 небольших строк, если строк больше, то функция переносится
// в отдельный метод внутри виджета.
//
//

// BAD:

class WebAntBadButtonWidget extends StatelessWidget {
  const WebAntBadButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        dynamic a = 1;

        a.add();

        a.remove();

        a.indexOf(1);
      },
    );
  }
}

// GOOD:

class WebAntGoodButtonWidget extends StatelessWidget {
  const WebAntGoodButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onClick,
    );
  }

  void _onClick() {
    dynamic a = 1;

    a.add();

    a.remove();

    a.indexOf(1);
  }
}

//
//
// Внутри дерева виджетов категорически запрещено создавать
// экземпляры классов (не виджетов), например ScrollController,
// вместо этого делаем виджет Statefull и создаем внутри него final переменную
// для этого экземпляра.
//
//

// BAD:

class WebAntBadInstanceWidget extends StatelessWidget {
  const WebAntBadInstanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextField(
        controller: TextEditingController(),
      ),
    );
  }
}

// GOOD:

class WebAntGoodInstanceWidget extends StatefulWidget {
  const WebAntGoodInstanceWidget({super.key});

  @override
  State<WebAntGoodInstanceWidget> createState() => _WebAntGoodInstanceWidgetState();
}

class _WebAntGoodInstanceWidgetState extends State<WebAntGoodInstanceWidget> {
  final inputController = TextEditingController();

  // После создания контроллера внутри стейта не забываем делать dispose
  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextField(
        controller: inputController,
      ),
    );
  }
}

//
//
// Блоки провайдим в AutoRouteWrapper.
//
//

class WebAntBlocProvidingWidget extends StatelessWidget implements AutoRouteWrapper {
  const WebAntBlocProvidingWidget({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleBloc(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextField(
        controller: TextEditingController(),
      ),
    );
  }
}

//
//
// В стейте виджета не храним какие-либо данные, их место в стейте BLoC.
//
//

// BAD:

class WebAntStateWidget extends StatefulWidget {
  const WebAntStateWidget({super.key});

  @override
  State<WebAntStateWidget> createState() => _WebAntStateWidgetState();
}

class _WebAntStateWidgetState extends State<WebAntStateWidget> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
        ),
        MaterialButton(
          onPressed: () => setState(
            () {
              count++;
            },
          ),
        ),
      ],
    );
  }
}

//
//
// Для констант создаем отдельный файл и используем их оттуда
//
//

// BAD:

class WebAntConstantsBadWidget extends StatelessWidget {
  const WebAntConstantsBadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(26),
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onPressed: () {},
        ),
      ),
    );
  }
}

// GOOD:

class AppWidgetConsts {
  static const defaultScaffoldPadding = EdgeInsets.all(26);
  static const defaultButtonPadding = EdgeInsets.symmetric(horizontal: 12);
}

class WebAntConstantsGoodWidget extends StatelessWidget {
  const WebAntConstantsGoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppWidgetConsts.defaultScaffoldPadding,
        child: MaterialButton(
          padding: AppWidgetConsts.defaultButtonPadding,
          onPressed: () {},
        ),
      ),
    );
  }
}

//
//
// Мы никогда не используем print или debugPrint
//
//

// BAD:

void method() {
  print('я просто так дебажу');
}
