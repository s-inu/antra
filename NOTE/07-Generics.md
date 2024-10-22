DRY principle

Java POJOs

Type parameter constraint
- [link](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/constraints-on-type-parameters)

nullable ref type -> .csproj -> ImpliciUsing
>You can also specify the [System.Enum](https://learn.microsoft.com/en-us/dotnet/api/system.enum) type as a base class constraint. The CLR always allowed this constraint, but the C# language disallowed it.[link](https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/constraints-on-type-parameters#:~:text=You%20can%20also%20specify%20the%20System.Enum%20type%20as%20a%20base%20class%20constraint.%20The%20CLR%20always%20allowed%20this%20constraint%2C%20but%20the%20C%23%20language%20disallowed%20it.)

Interface

abstract class vs interface

!??? Convert [link](https://learn.microsoft.com/en-us/dotnet/fundamentals/runtime-libraries/system-convert)
- `Convert.ToInt32()`

SOLID:
- Single Responsibility
  - Controller/Web layer: handle req/res, validation, security check
  - Service/Business layer: deals with business logic
  - Data/Repository layer: interact with the database
- Open/closed[[06-OOP]]
  - inheritance
  - extension methods
- Liskov Substitution: 
  - derived classes should be substitutable for their base class 
- Interface Segregation:
 - > no client should be forced to depend on methods it does not use
- Dependency Inversion
  - depend on abstractions instead of concrete classes, helpful to loosely coupled code. high level modules should not depend on low level modules, they should depend on abstraction instead
  - IOC

Collection
- Non-generic Collections: `Systems.Collections.Generics`
  - takes objects
- Generic Collection: `Systems.Collections.Generics`
  - specific type

advantages of generic collection:
1. type safety
2. better performance: unboxing/boxing
3. flexibility
4. maintainablity

