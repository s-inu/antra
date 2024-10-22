delegate
- type safe function pointer
- takes function or method as a parameter
- reference type

built-in delegate
- `Action`
  - returns `void`
- `Predicate`
  - returns `bool`
- `Func`
  - returns `R `

delegate usage
- `delegate`
```C#
Action<int> add = delegate(int a, int b){cwl(a+b);
```
- lambda

anonymous function
- created on the fly

anonymous type

var

??? contravariance, covariance

method group conversion [link](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/conversions#10215-anonymous-function-conversions-and-method-group-conversions)

exception handling
- `System.Exception`
  - `OutOfMemoryException`
  - `StackOverflowException`
  - `ArgumentException`

managed heap & unmanaged heap
- managed: gc
- unmanaged: files, db connections, call `Dispose()` of `IDisposable`