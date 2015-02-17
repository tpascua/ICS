import java.io.*;
import java.util.*;


public class JshShell {
	public static void main(String[] args) throws java.io.IOException {
		String commandLine;
  		BufferedReader console = new BufferedReader (new InputStreamReader(System.in));
 


  		while (true) {
  			// read what the user entered
  			System.out.print("jsh>");
  			commandLine = console.readLine(); {
  			// if the user entered a return, just loop again
  			if (commandLine.equals("")) { continue; } 
  			else if(commandLine.equalsIgnoreCase("exit") || commandLine.equalsIgnoreCase("quit"))  { System.exit(0); }

  			// Split the string into a String Array
		  
  			ArrayList<String> parms = new ArrayList<String>();
  			String[] lineSplit = commandLine.split(" ");
   
  			
  			for (int i=0; i<lineSplit.length; i++)  { parms.add(lineSplit[i]); }
  			//System.out.println(lineSplit[i]);  // testing, wanted to make sure its working

  			ProcessBuilder pb = new ProcessBuilder(parms);
  			Process proc = pb.start();

  			// obtain the input stream
  			InputStream is = proc.getInputStream();
  			InputStreamReader isr = new InputStreamReader(is);
  			BufferedReader br = new BufferedReader(isr);

  			// read what is returned by the command
  			String line;
  			while ( (line = br.readLine()) != null) System.out.println(line);
  			br.close();

  			}
  		}
	}
}	

