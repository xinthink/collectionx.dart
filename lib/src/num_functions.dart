/// Function-styled arithmetic operator `+`
T add<T extends num>(T a, T b) => (a + b) as T;

/// Function-styled arithmetic operator `-`
T subtract<T extends num>(T a, T b) => (a - b) as T;

/// Function-styled arithmetic operator `*`
T multiply<T extends num>(T a, T b) => (a * b) as T;

/// Function-styled arithmetic operator `/`
double divide<T extends num>(T a, T b) => a / b;

/// Function-styled arithmetic operator `~/`
int divideTruncated<T extends num>(T a, T b) => a ~/ b;
