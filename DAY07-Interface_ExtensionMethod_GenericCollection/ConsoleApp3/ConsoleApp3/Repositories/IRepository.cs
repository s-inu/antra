namespace ConsoleApp3.Repositories;

public interface IRepository <T> where T: class
{
    //CRUD Operations

    int Insert(T obj);
    int Update(T obj);
    int Delete(int id);
    List<T> GetAll();
    T GetById(int id);
}