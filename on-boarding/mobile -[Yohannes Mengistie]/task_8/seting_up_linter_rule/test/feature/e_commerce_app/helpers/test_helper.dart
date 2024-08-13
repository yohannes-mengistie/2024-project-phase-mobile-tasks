import 'package:mockito/annotations.dart';
import 'package:seting_up_linter_rule/core/error/platForm/network_info.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_local_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/data/data_sources/product_remote_data_source.dart';
import 'package:seting_up_linter_rule/feature/e_commerce_app/domain/repository/e_commerce_repository.dart';

@GenerateMocks([ECommerceRepository,ProductRemoteDataSource,ProductLocalDataSource,NetworkInfo ])
void main(){}