dotnet core vs dotnet framework

Program.cs

value type vs reference type
- value type holds the value, and reference type holds the reference
- value type is on stack; reference type is on heap
- value type will be GCed, reference type will
- ??? value type is created by struct or enum; reference type is created by class, interface, delegate or array
- value type does not accept null, but reference type does

nullable operator:`?`
```C#
int i? = null;
```
??? Optional in Java

CLR: Common Language Runtime

heap memory: generation 0,1 & 2

managed heap & unmanaged heap
- managed heap: managed by GC
- unmanaged heap: Dispose() of `IDisposable`


string
- immutable
- `StringBuilder`

enum

namespace

access modifiers
- public
- private
- protected
- internal: ??? assembly

modes of params passsing
- pass by value
- pass by reference `ref`
- optional: defining default param allowed
- out mode `out`
- params

`ref` vs `out`
- `ref` takes initialized value, but `out` takes both
- `ref` and `out` are pass-by-ref

boxing & unboxing

`[Obsolete]`