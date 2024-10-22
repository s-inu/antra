namespace ConsoleApp4;

public class FileProcessor
{
    public void ProcesFile(string FileName)
    {
        FileStream fileStream = null;
        try
        {
            //Open the file stram 
            fileStream = new FileStream("Filename.txt", FileMode.Open);

            //perform some operations
            //......

            fileStream.Close();
        }
        catch (IOException ex)
        {
            //handle exception
        }
        finally
        {
            if (fileStream != null)
            {
                fileStream.Dispose();
            }
        }
    }
}