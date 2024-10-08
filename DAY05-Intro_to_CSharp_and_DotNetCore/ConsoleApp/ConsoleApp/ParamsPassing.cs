namespace ConsoleApp;

public class ParamsPassing
{
    public void PassingByValue(int a , int b)
    {
        a = 80;
        b = 20;
        Console.WriteLine($"Inside of passing by value method: a ={a}, b = {b}");
    }
    
    public void PassingByReferecne( ref int a , ref int b)
    {
        a = 80;
        b = 20;
        Console.WriteLine($"Inside of passing by reference method: a ={a}, b = {b}");
    }

    public void AreaOfCircle(double radius,  double pi = 3.14)
    {
        Console.WriteLine($"The area of the circle is {pi * radius * radius}");
    }

    public bool IsAuthenticated(string username, string password, out string msg)
    {
        if (username == "Anjila" & password == "Antra1234")
        {
            msg = "You have been verified";
            return true;
        }
        else
        {
            msg = "Invalis Credentials";
            return false;
        }
    }

    [Obsolete("Use AddNumbers(params int[] arr) instead", true)]
    public int AddTwoNumbers(int a, int b)
    {
        return a + b;
    }
    
    [Obsolete("Use AddNumbers(params int[] arr) instead", true)]
    public int AddThreeNumbers(int a, int b, int c)
    {
        return a + b + c;
    }

    public int AddNumbers(params int[] arr)
    {
        int sum = 0;
        for (int i = 0; i < arr.Length; i++)
        {
            sum = sum + arr[i];
        }

        return sum;
    }
}