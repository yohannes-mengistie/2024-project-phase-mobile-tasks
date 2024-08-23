part of 'e_commerce_bloc.dart';

sealed class ECommerceEvent extends Equatable {
  const ECommerceEvent();

  @override
  List<Object> get props => [];
}

class LoadAllProductEvent extends ECommerceEvent {
  const LoadAllProductEvent();
}

class GetSingleProductEvent extends ECommerceEvent {
  final String productId;

  const GetSingleProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class UpdateProductEvent extends ECommerceEvent {
  final String productId;
  final ProductModel updateProductDetails;

  const UpdateProductEvent(this.productId, this.updateProductDetails);
  @override
  List<Object> get props => [productId, updateProductDetails];
}

class DeleteProductEvent extends ECommerceEvent {
  final String productId;

  const DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class CreatProductEvent extends ECommerceEvent {
  final ProductModel newProductDetails;
  const CreatProductEvent(this.newProductDetails);

  @override
  List<Object> get props => [newProductDetails];
}

class DummyECommerceEvent extends ECommerceEvent{}