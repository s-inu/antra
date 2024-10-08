using ConsoleApp2;

Customer c = new Customer(1, "Smith", "123@abc.com");
//c.CustomerName = "Smith";
Console.WriteLine(c.CustomerName);

Customer c1 = new Customer();
Customer c2 = new Customer(2, "Laura", "456@abc.com", "1234567890");
Console.WriteLine($"The phone number for the third customer is {c2.Phone}");


// FullTimeEmployee fte = new FullTimeEmployee();
// fte.PerformWork();
//
// PartTimeEmployee pte = new PartTimeEmployee();
// pte.PerformWork();
//
// Manager m = new Manager();

// Addittion addittion = new Addittion();
// addittion.AddNumbers(1.4,3.5);

Addittion.AddNumbers(1,2);

int a = 3;
string variableName = "hello world";
Console.WriteLine(a.OddOrEven());
