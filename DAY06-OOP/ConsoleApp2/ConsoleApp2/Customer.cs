namespace ConsoleApp2;

public class Customer
{
    public Customer()
    {
        
    }

    public Customer(int id, string customerName, string email, string phone)
    {
        Id = id;
        CustomerName = customerName;
        Email = email;
        Phone = phone;
    }
    public Customer( int id, string customerName, string email)
    {
        Id = id;
        CustomerName = customerName;
        Email = email;
    }
    
    //Full version property: private backing field + get and set methods

    // private string customerName;   //backing field
    //
    // public string CustomerName
    // {
    //     get
    //     {
    //         return customerName;
    //     }
    //     set
    //     {
    //         customerName = value;
    //     }
    // }
    //
    //Auto-generated property
   public string CustomerName { get; set; }
   
   //full version property
   private int id;

   public int Id
   {
       get
       {
           return id;
       }
      private set
       {
           if (id % 2 == 0)
           {
               id = value;
           }
          
       }
   }
   
   public string Email { get; set; }
   public string Phone { get; set; }

}