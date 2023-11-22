import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:webant_flutter_reglament/data_mapper.dart';
import 'package:webant_flutter_reglament/data_model.dart';
import 'package:webant_flutter_reglament/domain.dart';

part 'data.g.dart';

class ApiNewsRepository implements NewsRepository {
  final Mappr mapper = Mappr();

  @override
  Future<List<News>> fetchNews() async {
    DatabaseNewsService service = DatabaseNewsService();

    final response = await service.fetchNews();

    return mapper.convertList(response.results);
  }
}

@RestApi(baseUrl: 'https://api.spaceflightnewsapi.net/v4/')
abstract class ApiNewsService {
  factory ApiNewsService(
    Dio dio, {
    String baseUrl,
  }) = _ApiNewsService;

  @GET('articles/')
  Future<PaginationModel<NewsDTO>> fetchNews();
}

class DatabaseNewsService {
  Future<PaginationModel<NewsDTO>> fetchNews() async {
    return const PaginationModel(results: []);
  }
}
