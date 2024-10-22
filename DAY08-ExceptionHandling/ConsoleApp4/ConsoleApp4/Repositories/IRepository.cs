namespace ConsoleApp4.Repositories;

public interface IRepository<T> where T: class
{
    //List<T> Search(Predicate<T> Condition);
    List<T> Search(Func<T, bool> Condition);
    
    
    //Predicate can interchangably used with Func delegate
}