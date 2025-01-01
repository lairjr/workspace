function debounce<T extends (...args: any[]) => void>(fn: T, delay) {
  var timeout;
  return function () {
    var context = this;
    var args = arguments;
    clearTimeout(timeout);
    timeout = setTimeout(function () {
      fn.apply(context, args);
    }, delay);
  } as T;
}

export default debounce;
