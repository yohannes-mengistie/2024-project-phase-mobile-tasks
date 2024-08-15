part of 'e_commerce_bloc.dart';

sealed class ECommerceState extends Equatable {
  const ECommerceState();

  @override
  List<Object> get props => [];
}

class IntialState extends ECommerceState {
  const IntialState();
}

class LoadingState extends ECommerceState {
  const LoadingState();
}

class LoadedAllProductState extends ECommerceState {
  final List<Product> products;

  const LoadedAllProductState(this.products);
  @override
  // TODO: implement props
  List<Object> get props => [products];
}

class LoadedSingleProductState extends ECommerceState {
  final Product product;

  const LoadedSingleProductState(this.product);
  @override
  // TODO: implement props
  List<Object> get props => [product];
}

class ErrorState extends ECommerceState {
  final String message;

  const ErrorState(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class EmptyState extends ECommerceState {}
