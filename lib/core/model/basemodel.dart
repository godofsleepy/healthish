class BaseModel<T, E> {
  E? _error;
  T? data;
  bool success = true;

  setException(E error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  E get getException {
    return _error!;
  }
}
