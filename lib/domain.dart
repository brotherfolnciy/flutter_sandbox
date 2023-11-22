// Бизнес задача - получать список новостей

class News {
  final String? title;
  final String? description;
  final DateTime? createdAt;

  News({
    this.title,
    this.description,
    this.createdAt,
  });
}

abstract class NewsRepository {
  Future<List<News>> fetchNews();
}

class NewsUseCase {
  NewsUseCase({required this.repository});

  final NewsRepository repository;

  Future<List<News>> fetchNews() {
    return repository.fetchNews();
  }
}
