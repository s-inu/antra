using ConsoleApp5.DataModel;
using ConsoleApp5.Repositories;

namespace ConsoleApp5.Presentation;

public class ManageEmployee
{
    private EmployeeRepository _employeeRepository = new EmployeeRepository();

    // private Employee Demo(Employee employee)
    // {
    //     return employee;
    // }
    private void SelectDemo()
    {
        //Select * from employee
        //Query Syntax

        // var result = from employee in _employeeRepository.GetEmployees()
        //     select employee;
        
        //Method Syntax
        // var result = _employeeRepository.GetEmployees().Select(employee => employee);
        //
        // foreach (var employee in result)
        // {
        //     Console.WriteLine(employee.Id + "\t" + employee.FullName +"\t" + employee.Age + "\t" + employee.Department);
        // }
        
        //query syntax

        // var result = from employee in _employeeRepository.GetEmployees()
        //     select employee.FullName;
        
        //method syntax

        // var result = _employeeRepository.GetEmployees().Select(employee => employee.FullName);
        // foreach (var name in result)
        // {
        //     Console.WriteLine(name);
        // }
        
        //query syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     select new
        //     {
        //         Id = employee.Id,
        //         FullName = employee.FullName,
        //         Salary = employee.Salary
        //     };
        
        //method syntax

        // var result1 = _employeeRepository.GetEmployees().Select(x => new
        // {
        //     Id = x.Id,
        //     FullName = x.FullName,
        //     Salary = x.Salary
        //     
        // }).Distinct();
        // foreach (var employee in result)
        // {
        //     Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t"+ employee.Salary);
        // }

        //Distinct 
        
        //distinct department 
        //query syntax

        // var result = (from employee in _employeeRepository.GetEmployees()
        //     select employee.Department).Distinct();
        //method syntax 
        // var result = _employeeRepository.GetEmployees().Select(employee => employee.Department).Distinct();
        //
        // foreach (var department in result)
        // {
        //     Console.WriteLine(department);
        // }
        
        //first or FirstOrDefault
        
        //Method syntax

        //First or FirstOrDefault
        // var result = _employeeRepository.GetEmployees().Select(employee => new
        // {
        //     Id = employee.Id,
        //     FullName = employee.FullName,
        //     Salary = employee.Salary,
        //     Department = employee.Department
        // }).FirstOrDefault(x => x.Department == "sdjfksdf");
        
        //Single OR SingleOrDefault
        
        var result = _employeeRepository.GetEmployees().Select(employee => new
        {
            Id = employee.Id,
            FullName = employee.FullName,
            Salary = employee.Salary,
            Department = employee.Department
        }).SingleOrDefault(x => x.Department == "afsjjskjwr");
        
        Console.WriteLine(result);
    }

    private void OrderBy()
    {
        //Query syntax

        //var result = from employee in _employeeRepository.GetEmployees()
            // orderby employee.Salary descending, employee.FullName descending 
            // select new
            // {
            //     Id = employee.Id,
            //     FullName = employee.FullName,
            //     Salary = employee.Salary
            // };
            
        //Method Syntax

        var result = _employeeRepository.GetEmployees().Select (employee=> new
            {
                Id= employee.Id,
                Salary = employee.Salary,
                FullName = employee.FullName
            })
            .OrderBy(employee => employee.Salary)
            .ThenByDescending(employee=> employee.FullName);
        foreach (var employee in result)
        {
                 Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t"+ employee.Salary);
        }
    }

    private void WhereDemo()
    {
        //Query Syntax

        // var result = from employee in _employeeRepository.GetEmployees()
        //     where employee.Salary > 7000
        //     select new
        //     {
        //         Id = employee.Id,
        //         Name = employee.FullName,
        //         Salary = employee.Salary
        //     };
        
        //Method Syntax

        var result = _employeeRepository.GetEmployees().Where(e => e.Salary > 9000)
            .Select(employee => new
            {
                Id = employee.Id,
                Name = employee.FullName,
                Salary = employee.Salary
            });
        foreach (var employee in result)
        {
            Console.WriteLine(employee.Id + "\t" + employee.Name + "\t"+ employee.Salary);
        }
    }

    private void QuantifierDemo()
    {
        //method syntax

       // var result = _employeeRepository.GetEmployees().All(employee => employee.Salary > 4000);
        var result = _employeeRepository.GetEmployees().Any(employee => employee.Salary > 4000);
        Console.WriteLine(result);
    }

    private void GroupByDemo()
    {
        //Query Syntax
        // var result = from employee in _employeeRepository.GetEmployees()
        //     group employee by employee.Department;
        
        
        //Method Syntax

        var result = _employeeRepository.GetEmployees().GroupBy(employee => employee.Department);
        foreach (var group in result)
        {
            Console.WriteLine($"{group.Key} Department");
            foreach (var employee in group )
            {
                Console.WriteLine(employee.Id + "\t" + employee.FullName + "\t" + employee.Salary);
            }
        }
    }

    private void AggregationDemo()
    {
        //Method Syntax

        // var result = _employeeRepository.GetEmployees().Average(x => x.Salary);
        // Console.WriteLine(result);
        
        //average Salary By each Department

        var result = _employeeRepository.GetEmployees().GroupBy(employee => employee.Department)
            .Select(x => new
            {
                Department = x.Key,
                AverageSalary = Math.Round(x.Average(employee=> employee.Salary), 2),
                TotalSalary = x.Sum(employee=>employee.Salary)
            });
        foreach (var group in result)
        {
            Console.WriteLine(group.Department + "\t" + group.AverageSalary +"\t" + group.TotalSalary);
        }

    }
    public void Run()
    {
        AggregationDemo();
    }
    
}