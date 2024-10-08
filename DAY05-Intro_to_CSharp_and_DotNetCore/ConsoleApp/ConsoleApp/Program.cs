// // See https://aka.ms/new-console-template for more information
//
// using System.Text;
// using ConsoleApp;
//
// Console.WriteLine("Hello, World!");
//
// //int a = 10; 
// int? a = null;
// Console.WriteLine(a);
//
// if (a.HasValue)
// {
//     Console.WriteLine(a.Value);
// }
// else
// {
//     Console.WriteLine("a does not have any value");
// }
//
// double? b = 2.3423423;
// Console.WriteLine(b);
//
// float c = 3.545344f;
// Console.WriteLine(c);
//
//
// decimal d = 2.4353453m;
// Console.WriteLine(d);
//
// Console.WriteLine(d);
//
// //string s = "Welcome to C# class!";
// string s = null;
// Console.WriteLine(s);
//
// Console.WriteLine("The value of a is " + a );
//
// //String Interpolation
// Console.WriteLine($"The value of d is {d} ");
//
// string str = "hello world";
//
// StringBuilder sb = new StringBuilder("hello world");
// sb[0] = 'H';
// Console.WriteLine($"The value of sb is {sb}");
//
//
// int sunday = 1;
// int monday = 2;
// int tesday = 3;
// int wednesday = 4;
// int thursday = 5;
// int friday = 6;
// int saturday = 7;
//
// int daysOfWeek = 2;
//
// if (daysOfWeek == monday)
// {
//     Console.WriteLine("It's Monday");
// }
//
// DaysOfWeek today = DaysOfWeek.Monday;
// Console.WriteLine(today);
//
// int value = (int)today;
// Console.WriteLine(value);


using System.Runtime.Intrinsics.X86;
using ConsoleApp;

ParamsPassing demo = new ParamsPassing();
int x = 30;
int y = 10;
Console.WriteLine($"Before calling Passing By Value method: x ={x}, y ={y}");
demo.PassingByValue(x,y);
Console.WriteLine($"After calling Passing By Value method: x ={x}, y ={y}");
Console.WriteLine("==============================");
Console.WriteLine($"Before calling Passing By Reference method: x ={x}, y ={y}");
demo.PassingByReferecne(ref x, ref y);
Console.WriteLine($"After calling Passing By Reference method: x ={x}, y ={y}");
Console.WriteLine("==============================");
demo.AreaOfCircle(10);
demo.AreaOfCircle(10, 3);

string str;
Console.WriteLine(demo.IsAuthenticated("Anjila", "Antra1234", out str));
Console.WriteLine(str);

int[] arr = [1, 2, 3];
Console.WriteLine(demo.AddNumbers(arr));
Console.WriteLine(demo.AddNumbers(20, 20,30,20, x, y));
Console.WriteLine(demo.AddNumbers(1, 2, 4));

//demo.AddTwoNumbers(1, 2);
//demo.AddThreeNumbers(1, 2, 3);

//boxing
int i = 10;
object o = i; 
//unboxing
int j = (int)o;













