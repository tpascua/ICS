import java.io.*;

/**
 * A java program that runs the "ls -u" command line program as an external process.
 */
public class ProcessBuilderExample {

  private String command;
  
  public static void main(String[] args) {
    ProcessBuilderExample pbe = new ProcessBuilderExample("ls -u");
    pbe.runProcess();
  }
  
  public ProcessBuilderExample(String s) {
    command = s;
  }
   
  public void runProcess() {
    
    command = command.trim();
    
    // Split the command into an array of strings
    String[] tokens = command.split("[ \t\n]+");
    
    // ProcessBuilder is an object that knows how to create
    // external processes like "ls -u"
    ProcessBuilder pb = null;
    Process p = null;
    
    // Pass ProcessBuilder the command as an array of strings
    pb = new ProcessBuilder(tokens);
    
    System.err.println("Starting process " + tokens[0] + "...");
    
    try {
      // By calling start on my ProcessBuilder object, I get back a 
      // process object that is running "ls -u"
      p = pb.start();
    }
    catch (IOException e) {
      System.err.println(e.getMessage());
      System.err.println("Cannot start process");
      return;
    }
    
    // Input/Output - from the perspective of the java program
    //    getErrorStream() gives an InputStream because the current
    //        process reads input from the created process's stderr
    //    getInputStream() gives an InputStream because the current
    //        process reads input from the created process's stdout
    //    getOutputStream() gives an OutputStream because the current
    //        process writes output into the created process's stdin
    System.err.println("Establishing streams to communicate with process...");
    InputStream  sstderr = p.getErrorStream();
    InputStream  sstdout = p.getInputStream();
    OutputStream sstdin  = p.getOutputStream();
    
    // Typical to create BufferReader objects associated to all above streams
    BufferedReader stderr = new BufferedReader(new InputStreamReader(sstderr));
    BufferedReader stdout = new BufferedReader(new InputStreamReader(sstdout));
    BufferedWriter stdin = new BufferedWriter(new OutputStreamWriter(sstdin));
    
    // Communication can now happen when necessary, e.g., reading one line
    // from the process' stdout, and printing it out to jvm stdout
    try {
      String line = stdout.readLine();
      System.out.println("Process output line: " + line);
      line = stdout.readLine();
      System.out.println("Process output line: " + line);
      line = stdout.readLine();
      System.out.println("Process output line: " + line);
    }
    catch (IOException e) {
      System.err.println("IO Error");
    }
    
    // Wait for the process to terminate
    System.err.println("Waiting for the process to complete");
    try {
      int returnValue = p.waitFor();
      System.err.println("Process completed with return value" + returnValue);
    }
    catch (InterruptedException e) {
      // Do nothing for now...this is about threads and will
      // be explained later.
    }
    
    // close streams
    try {
      sstderr.close();
      sstdout.close();
      sstdin.close();
    }
    catch (IOException e) {
      System.err.println("IO Error");
    }
    
    // Destroy the process is necessary
    try {
      Thread.sleep(100);
    }
    catch (InterruptedException e) {
      // Do nothing for now...this is about threads and will
      // be explained later
    }
    
    p.destroy();
    
    return;
  }
  
}