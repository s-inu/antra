backing field
> A private field that stores the data exposed by a public property is called a _backing store_ or _backing field_. You can declare `public` fields, but then you can't prevent code that uses your type from setting that field to an invalid value or otherwise changing an object's data.

encapsulation 

??? mix using auto-completed 

??? field vs property

`T t = new(){...}` target-type new expression & object initializer

casting
- cast expression [link](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/types/casting-and-type-conversions)
- `is`, `as`, `typeof` [link](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/type-testing-and-cast)
  - `if (var1 is A a){f(a);...}` declaration pattern
  - `as` is equivalent to `E is T ? (T)(E) : (T)null`

!??? a lot of patterns [link](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/patterns#declaration-and-type-patterns)

abstract class

sealed class

Derived class ctor
- `public SomeClass(...): base(param1, param2,..)`

static class

static class vs sealed class

static class vs abstract class

use case of static class

extension methods
- SOLID: open/close principle
> [chatgpt](https://chatgpt.com/c/670ad147-c8fc-8013-9190-06721b98b698)
> Extension methods allow you to add new methods to existing types without altering the type itself. This is done by defining a static method in a static class, where the "this" keyword is used to indicate which type the method extends.

built-in methods
- LINQ, Language Integrated Query

naming convention:
- pascal casing: PascalCasing
  - class, method, interface, namespace, property, delegate
- camel casing: camelCasing
  - variable