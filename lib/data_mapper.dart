import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:webant_flutter_reglament/data_model.dart';
import 'package:webant_flutter_reglament/domain.dart';

import 'data_mapper.auto_mappr.dart';

@AutoMappr([
  MapType<NewsDTO, News>(fields: [
    Field('description', from: 'summary'),
    Field('createdAt', from: 'publishedAt'),
  ]),
])
class Mappr extends $Mappr {}
