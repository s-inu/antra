// See https://aka.ms/new-console-template for more information


using ConsoleApp4;
using ConsoleApp4.Presentation;

//MathDelegate mathDelegate = new MathDelegate(ArithmeticOperations.Subtract);
//MathDelegate mathDelegate = new MathDelegate(ArithmeticOperations.Add);
//Console.WriteLine(mathDelegate(40,10));

//PredefinedDelegates predefinedDelegates = new PredefinedDelegates();
//predefinedDelegates.ActionExample();
//predefinedDelegates.PredicateDemo();
// predefinedDelegates.FuncDemo();
//
// var person = new
// {
//     Name = "Smith",
//     Age = 30
// };

//var a = 3;

// ManageEmployee manageEmployee = new ManageEmployee();
// manageEmployee.Print();

try
{
    Console.WriteLine("Enter the first number");
    int num1 = Convert.ToInt32(Console.ReadLine());
    if (num1 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter the second number");
    int num2 = Convert.ToInt32(Console.ReadLine());
    if (num2 < 0)
    {
        throw new NumberException();
    }

    Console.WriteLine("Enter opeartion ");
    string operation = Console.ReadLine();

    ExceptionHandlingDemo demo = new ExceptionHandlingDemo();
    Console.WriteLine(demo.Calculate(num1, num2, operation));
}
catch (DivideByZeroException ex)
{
    Console.WriteLine(ex.Message);
    //logging
}
catch (ArgumentOutOfRangeException ex)
{
    Console.WriteLine(ex.Message);
}
catch (FormatException ex)
{
    Console.WriteLine(ex.Message);
}
catch (NumberException ex)
{
    Console.WriteLine(ex.Message);
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
finally
{
    Console.WriteLine("Hello finally block");
}








