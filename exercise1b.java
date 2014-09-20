/** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * exercise1b.java
 * Exercise 1B for ICS 475
 * September 22, 2014
 * @author Tyler Pascua
 * This program will translate two nucleotide sequences into amino acid sequences
 * then compare the two amino acid sequences.
 * The user will have to give the program two text files containing nucleotide sequences
 * via prompts given by the program.  Each time the user tells the program which file to use,
 * the program will ask whether the file given is in either 5'->3' or 3'->5'.  After that,
 * the program will ask how you would like the two files translated and compared: by mRNA, 
 * DNA, or using both methods. 
 * It will then out the results in another pop up window.  If the user uses very large 
 * sequences, the pop up window will probably not fit fully onto the screen.  You can 
 * move the window around via click and drag, and you can hit 'enter' on the keyboard 
 * pif the 'OK' button cannot be found.
 ** * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
import java.util.*;
import javax.swing.JOptionPane;
import javax.swing.JFileChooser;
import javax.swing.filechooser.*;
import java.lang.Iterable;
import java.io.File;
import java.io.IOException;
import java.io.FileReader;
import java.io.BufferedReader;

public class exercise1b {
	public static void main(String[] args) throws IOException{
		/* * * * * * * * * * * * * *
		 * STEP1
		 * READ IN VARIABLES
		 * create i/o variables infile1, infile2, and outfile
		 * 
		 * open input file 1: infile1
		 * open input file 2: infile2
		 * open output file: outfile
		 * 
		 * INITIALIZE VARIABLES
		 * seq1 = seq2 = " "
		 * aminoseq1 = aminoseq2 = " "
		 * 
		 * READ IN DATA
		 * read and discard first line of data in infile1
		 * for each line of data in file1
		 * 		concatenate line of data to seq1
		 * read and discard forst line of data in infle2
		 * for each line of data in infile2
		 * 		concatenate line of data to seq2
		 * * * * * * * * * * * * * * */
		/* Initialize all variables used */
		String 	infile1, infile2, mutations, seq1, seq2, tempSeq, aminoSeq1, aminoSeq2,
				result, line, dnaSeq1, dnaSeq2, dnaAminoSeq1, dnaAminoSeq2 = new String();	// The strings used
		infile1 = infile2 = mutations = dnaSeq1 = dnaSeq2 = tempSeq = "";					// Initialize the result strings	
		Dictionary dictionary = new Dictionary();											// Create the Map used
		File file = new File("");															// Initialize the file variable
		int dna = 0;																		// dna=0, translates/ 1, keep as dna/ 2, both
		int template = 0;																	// template=0, 5'->3' / 1, 3'->5'
		
		/* Ask user for first sequence 
		 * Program prompts user with a pop up to select the
		 * file that you want to use as the first sequence
		 * */
		JFileChooser chooser = new JFileChooser();
		FileFilter filter = new FileNameExtensionFilter("Text Files", "txt");
		chooser.setFileFilter(filter);
		int returnVal = chooser.showOpenDialog(null);
		if(returnVal == JFileChooser.APPROVE_OPTION) {
		   //System.out.println("You chose to open this file: " + chooser.getSelectedFile().getName());  //test line
		   file = chooser.getSelectedFile();	//  If the user chooses a file, file = chosen file 
		} else { System.exit(0); }  			//  If the user cancels the open window, the program will just quit.
		
		/* Open File 1 */
		//File file = new File(PATH1);
		BufferedReader br = new BufferedReader(new FileReader(file));
		line = br.readLine();											// discard the first line (by reading it)
		while ((line = br.readLine()) != null) { infile1 += line; } 	// While the next read line is not null, stick it into infile1
		br.close();														// close the reader
		
		/* Opens a prompt asking how you want the sequence input translated */
		Object[] FourOptions = {"Template 5' -> 3'", " Template 3' -> 5'", "Nontemplate 5' -> 3'", " Nontemplate 3' -> 5'"};
		template = JOptionPane.showOptionDialog(null,
		    "Is the sequence in " + file +" a"
		    + "template or nontemplate strand?"
		    + "What is the strand's orientation?",			// Message
		    "Template Question",							// Message Title
		    JOptionPane.YES_NO_OPTION,						// Button Type
		    JOptionPane.QUESTION_MESSAGE,					// Icon
		    null,											// ?
		    FourOptions,									// What choices to use
		    FourOptions[0]);								// Default choice

		
		seq1 = infile1;				/* Place received text into new Strings */
		seq1 = seq1.toUpperCase();	/* Capitalize the two sequences, just in case the inputs were in lower case */
		if (template == 1 || template == 2) { seq1 = new StringBuilder(seq1).reverse().toString(); }	/* Inverse the string */
		if (template == 2 || template == 3) { 															/* Get the complement of the string */
			for (int i = 0; i <= seq1.length()-1; i++) {
				if (seq1.charAt(i) == 'A') { tempSeq += 'T'; }
				if (seq1.charAt(i) == 'T') { tempSeq += 'A'; }
				if (seq1.charAt(i) == 'G') { tempSeq += 'C'; }
				if (seq1.charAt(i) == 'C') { tempSeq += 'G'; }
			}
			seq1 = tempSeq;
			tempSeq = "";
		}
		
		/* Ask user for the second sequence 
		 * Program prompts user with a pop up to select the
		 * file that you want to use as the first sequence
		 * */
		chooser = new JFileChooser();
		filter = new FileNameExtensionFilter("Text Files", "txt");
		chooser.setFileFilter(filter);
		returnVal = chooser.showOpenDialog(null);
		if(returnVal == JFileChooser.APPROVE_OPTION) { file = chooser.getSelectedFile(); }	// If the user chooses a file, file = chosen file  
		else { System.exit(0); }															// If the user cancels the open window, the program will just quit.
		
		/* Open File 2 */
		//file = new File(PATH2);
		br = new BufferedReader(new FileReader(file));
		line = br.readLine();											// discard the first line (by reading it)
		while ((line = br.readLine()) != null) { infile2 += line; }		// While the next read line is not null, stick it into infile2
		br.close();														// close the reader
		
		/* Opens a prompt asking how you want the sequence input translated */
		template = JOptionPane.showOptionDialog(null,
			    "Is the sequence in " + file +" a"
			    + "template or nontemplate strand?"
			    + "What is the strand's orientation?",			// Message
			    "Template Question",							// Message Title
			    JOptionPane.YES_NO_OPTION,						// Button Type
			    JOptionPane.QUESTION_MESSAGE,					// Icon
			    null,											// ?
			    FourOptions,									// What choices to use
			    FourOptions[0]);								// Default choice
		
		
		seq2 = infile2;				/* Place received text into new Strings */
		seq2 = seq2.toUpperCase();	/* Capitalize the two sequences, just in case the inputs were in lower case */
		if (template == 1) { seq2 = new StringBuilder(seq2).reverse().toString(); }
		if (template == 1 || template == 2) { seq1 = new StringBuilder(seq1).reverse().toString(); }	/* Inverse the string */
		if (template == 2 || template == 3) { 															/* Complement the string */
			for (int i = 0; i <= seq2.length()-1; i++) {
				if (seq2.charAt(i) == 'A') { tempSeq += 'T'; }
				if (seq2.charAt(i) == 'T') { tempSeq += 'A'; }
				if (seq2.charAt(i) == 'G') { tempSeq += 'C'; }
				if (seq2.charAt(i) == 'C') { tempSeq += 'G'; }
			}
			seq2 = tempSeq;
			tempSeq = "";
		}
		
		/* If the two sequences entered are not of equal length, the program will tell you, then forcibly quit. */
		if (seq1.length() != seq2.length()) {
			JOptionPane.showMessageDialog(null, "The two input sequences are not of equal length.", "Error" , JOptionPane.WARNING_MESSAGE);
			System.exit(0);
		}
		/* If one or both of the input seqences is not a nucleotide sequence, the program will let you know, then forcibly quit */
		if ((seq1.length() % 3 != 0) || (seq2.length() % 3 != 0)) { 
			JOptionPane.showMessageDialog(null, "One or both of the input sequences may not be a valid nucleotide sequence.", "Error" , JOptionPane.WARNING_MESSAGE);
			System.exit(0);
		}		
		/* Capitalize the two sequences, just in case the inputs were in lower case */
		
		

		/* * * * * * * * * * * * * *
		 * STEP 2
		 * TRANSCRIPTION
		 * TRANSCRIBE SEQUENCE 1 - REPEAT STEPS FOR SEQUENCE 2 
		 * for each i from 0 to length of seq1 - 1, inclusive
		 * 		if (seq1[i] == 'T')
		 * 			seq1[i] = 'U'
		 * * * * * * * * * * * * * */
		/* Asks the user if they want to keep the inputs entered as DNA, translate them into mRNA, or do both */
		/* Opens a prompt asking how you want the sequence input translated */
		Object[] threeoptions = {"mRNA", "DNA", "Both"};
		dna = JOptionPane.showOptionDialog(null,
		    "How would you like the sequences translated as?",	// Message
		    "Translation Question",								// Message Title
		    JOptionPane.YES_NO_CANCEL_OPTION,					// Button Type
		    JOptionPane.QUESTION_MESSAGE,						// Icon
		    null,												// ?
		    threeoptions,											// What choices to use
		    threeoptions[0]);										// Default choice
		
		/* If dna = 0, then translation will happen */
		if (dna == 0) {
			seq1 = seq1.replace('T', 'U');
			seq2 = seq2.replace('T', 'U');
		} else if (dna == 1) {
			/* If dna = 1, then translation will not happen */
			dnaSeq1 = seq1;
			dnaSeq2 = seq2;
		} else if (dna == 2) {
			/* If dna = 2, then both results will be given */
			dnaSeq1 = seq1;
			dnaSeq2 = seq2;
			seq1 = seq1.replace('T', 'U');
			seq2 = seq2.replace('T', 'U');			
		}

		
		/* * * * * * * * * * * * * *
		 * STEP 3
		 * TRANSLATION
		 * CREATE A MAP (DISTIONARY OR HASH TABLE) OF KEY/VALUE PAIRS
		 * REPRESENTING EACH OF THE 64 POSSIBLE CODONS AND THE AMINO ACID
		 * (IN ONE-LETTER CODE) CORRESPONDING TO EACH
		 * codes = map of all codon/amino acid pairs
		 * 
		 * TRANSLATE SEQUENCE 1 - REPEAT FOR SEQUENCE 2
		 * for each i from 0 to len(seq1)-3, inclusive, iterate by 3
		 * 		aminoseq1 = aminoseq1 + codes[seq1.substring(i, 3)]
		 * * * * * * * * * * * * * */
		aminoSeq1 = dictionary.codonToAmino(seq1);
		aminoSeq2 = dictionary.codonToAmino(seq2);
		dnaAminoSeq1 = aminoSeq1.replace('U', 'T');
		dnaAminoSeq2 = aminoSeq2.replace('U', 'T');
		
		/* * * * * * * * * * * * * * 
		 * STEP 4
		 * STRING COMPARISON
		 * 	mctr = 0;  mismatch counter
		 * for each i from 0 to len(aminoseq1)-1, inclusive
		 * 		if (aminoseq1[i] != aminoseq2[i])
		 * 			OUTPUT MUTATION SHORTHAND;  EG K136R
		 * 			output aminoseq1[i] + (i+1) + aminoseq2[i]
		 * 			write aminoseq1[i] + (i+1) + aminoseq2[i] to outfile
		 * 			mctr++;
		 * if mctr==0
		 * 		output "no mismatches found - string are indentical"
		 * * * * * * * * * * * * * */	
		int mctr = 0; 											// mismatch counter
		for (int i=0; i <= aminoSeq1.length()-1; i++) {			
			if (aminoSeq1.charAt(i) != aminoSeq2.charAt(i)) {  	// if true, there is a mismatch
				String temp = Character.toString(aminoSeq1.charAt(i)) + Integer.toString(i+1) + Character.toString(aminoSeq2.charAt(i));
				mutations += temp + "  ";
				mctr++;
			}
		}
		/* If there were no mismatches, the program will let you know */
		if (mutations == "") { mutations = "No mismatches found - strings are identical"; }
		
		/* Final Results 
		 * Displays the results in a popup window
		 * */
		result = "";	
		if (dna == 0) { /* mRNA */
			result += "Number of Mutations: " + mctr + "\n";
			result += "Mutations: " + mutations + "\n";
			result += "Sequence 1 Nucleotides: " + seq1 + "\n";
			result += "Sequence 2 Nucleotides: " + seq2 + "\n";
			result += "Sequence 1 Amino Acids: " + aminoSeq1 + "\n";
			result += "Sequence 2 Amino Acids: " + aminoSeq2 + "\n";
			//System.out.println(result);  // terminal printout
			JOptionPane.showMessageDialog(null, result, "Results - mRNA",
					JOptionPane.INFORMATION_MESSAGE); // popup window		
		} else if (dna == 1) { /* DNA */
			result += "Number of Mutations: " + mctr + "\n";
			result += "Mutations: " + mutations.replace('U', 'T') + "\n";
			result += "Sequence 1 Nucleotides: " + dnaSeq1 + "\n";
			result += "Sequence 2 Nucleotides: " + dnaSeq2 + "\n";
			result += "Sequence 1 Amino Acids: " + dnaAminoSeq1 + "\n";
			result += "Sequence 2 Amino Acids: " + dnaAminoSeq2 + "\n";
			//System.out.println(result);  // terminal printout
			JOptionPane.showMessageDialog(null, result, "Results - DNA",
					JOptionPane.INFORMATION_MESSAGE); // popup window		
		} else if (dna == 2) { /* Both mRNA & DNA */
			result += "Number of Mutations: " + mctr + "\n";
			result += "Mutations: " + mutations + "\n";
			result += "Sequence 1 Nucleotides: " + seq1 + "\n";
			result += "Sequence 2 Nucleotides: " + seq2 + "\n";
			result += "Sequence 1 Amino Acids: " + aminoSeq1 + "\n";
			result += "Sequence 2 Amino Acids: " + aminoSeq2 + "\n";
			//System.out.println(result);  // terminal printout
			JOptionPane.showMessageDialog(null, result, "Results - mRNA",
					JOptionPane.INFORMATION_MESSAGE); // popup window
			result = "";
			result += "Number of Mutations: " + mctr + "\n";
			result += "Mutations: " + mutations.replace('U', 'T') + "\n";
			result += "Sequence 1 Nucleotides: " + dnaSeq1 + "\n";
			result += "Sequence 2 Nucleotides: " + dnaSeq2 + "\n";
			result += "Sequence 1 Amino Acids: " + dnaAminoSeq1 + "\n";
			result += "Sequence 2 Amino Acids: " + dnaAminoSeq2 + "\n";
			//System.out.println(result);  // terminal printout
			JOptionPane.showMessageDialog(null, result, "Results - DNA",
					JOptionPane.INFORMATION_MESSAGE); // popup window
		}
	}
}
/**
 * Dictionary.class
 * A container class for the map of codons - amino acids
 * @author Tyler Pascua
 */
class Dictionary{
	private Map<String, String> dictionary;
	/**
	 * CONSTRUCTOR
	 * Creates a dictionary 
	 */
	public Dictionary() {
		dictionary = new HashMap<String, String>();
		
		// ALANINE
		dictionary.put("GCU", "A");
		dictionary.put("GCC", "A");
		dictionary.put("GCA", "A");
		dictionary.put("GCG", "A");
		dictionary.put("GCT", "A");
		
		// ARGININE
		dictionary.put("CGU", "R");
		dictionary.put("CGC", "R");
		dictionary.put("CGA", "R");
		dictionary.put("CGG", "R");
		dictionary.put("AGA", "R");
		dictionary.put("AGG", "R");
		dictionary.put("CGT", "R");

		// ASPARAGINE
		dictionary.put("AAU", "N");
		dictionary.put("ASC", "N");
		dictionary.put("AAT", "N");
		
		// ASPARTIC ACID
		dictionary.put("GAU", "D");
		dictionary.put("GAC", "D");
		dictionary.put("GAT", "D");

		// CYSTEINE
		dictionary.put("UGU", "C");
		dictionary.put("UGC", "C");
		dictionary.put("TGT", "C");
		dictionary.put("TGC", "C");
		
		// GLUTAMINE
		dictionary.put("CAA", "Q");
		dictionary.put("CAG", "Q");
		
		// GLUTAMIC ACID
		dictionary.put("GAA", "E");
		dictionary.put("GAG", "E");
		
		// GLYCINE
		dictionary.put("GGU", "G");
		dictionary.put("GGC", "G");
		dictionary.put("GGA", "G");
		dictionary.put("GGG", "G");
		dictionary.put("GGT", "G");
		
		// HISTIDINE
		dictionary.put("CAU", "H");
		dictionary.put("CAC", "H");
		dictionary.put("CAT", "H");
		
		// ISOLEUCINE
		dictionary.put("AUU", "I");
		dictionary.put("AUC", "I");
		dictionary.put("AUA", "I");
		dictionary.put("ATT", "I");
		dictionary.put("ATC", "I");
		dictionary.put("ATA", "I");
		
		// LEUCINE
		dictionary.put("UUA", "L");
		dictionary.put("UUG", "L");
		dictionary.put("CUU", "L");
		dictionary.put("CUC", "L");
		dictionary.put("CUA", "L");
		dictionary.put("CUG", "L");
		dictionary.put("TTA", "L");
		dictionary.put("TTG", "L");
		dictionary.put("CTT", "L");
		dictionary.put("CTC", "L");
		dictionary.put("CTA", "L");
		dictionary.put("CTG", "L");
		
		// LYSINE
		dictionary.put("AAA", "K");
		dictionary.put("AAG", "K");
		
		// METHIONINE
		dictionary.put("AUG", "M");
		
		// PHENLYLALANINE
		dictionary.put("UUU", "F");
		dictionary.put("UUC", "F");
		dictionary.put("TTT", "F");
		dictionary.put("TTC", "F");
		
		// PROLINE
		dictionary.put("CCU", "P");
		dictionary.put("CCC", "P");
		dictionary.put("CCA", "P");
		dictionary.put("CCG", "P");
		dictionary.put("CCT", "P");
		
		// SERINE
		dictionary.put("UCU", "S");
		dictionary.put("UCC", "S");
		dictionary.put("UCA", "S");
		dictionary.put("UCG", "S");
		dictionary.put("AGU", "S");
		dictionary.put("AGC", "S");	
		dictionary.put("TCT", "S");
		dictionary.put("TCC", "S");
		dictionary.put("TCA", "S");
		dictionary.put("TCG", "S");
		dictionary.put("AGT", "S");
		
		// THREONINE
		dictionary.put("ACU", "T");
		dictionary.put("ACC", "T");
		dictionary.put("ACA", "T");
		dictionary.put("ACG", "T");	
		dictionary.put("ACT", "T");
		
		// TRYPTOPHAN
		dictionary.put("UGG", "W");
		dictionary.put("TGG", "W");
		
		// TYROSINE
		dictionary.put("UAU", "Y");
		dictionary.put("UAC", "Y");
		dictionary.put("TAT", "Y");
		dictionary.put("TAC", "Y");
		
		// VALINE
		dictionary.put("GUU", "V");
		dictionary.put("GUC", "V");
		dictionary.put("GUA", "V");
		dictionary.put("GUG", "V");
		dictionary.put("GTT", "V");
		dictionary.put("GTC", "V");
		dictionary.put("GTA", "V");
		dictionary.put("GTG", "V");
		
		// STOP 
		dictionary.put("UAA", ".");
		dictionary.put("UGA", ".");
		dictionary.put("UAG", ".");
		dictionary.put("TAA", ".");
		dictionary.put("TGA", ".");
		dictionary.put("TAG", ".");
	}
	
	/**
	 * public String codonToAmino
	 * Take the input codon sequence and translate it into 
	 * an amino sequence
	 * @param codonSeq  The sequence to translate
	 * @return  the translated amino sequence
	 */
	public String codonToAmino(String codonSeq) {
		/* * * * * * * * * * * * * *
		 * TRANSLATE SEQUENCE 1 - REPEAT FOR SEQUENCE 2
		 * for each i from 0 to len(seq1)-3, inclusive, iterate by 3
		 * 		aminoseq1 = aminoseq1 + codes[seq1.substring(i, 3)]
		 * * * * * * * * * * * * * */
		String aminoSeq = "";
		for (int i=0; i < codonSeq.length(); i = i+3) {
			aminoSeq = aminoSeq + dictionary.get(codonSeq.subSequence(i, i+3));
			//System.out.println(i + " " + codonSeq.subSequence(i, i+3) + " " + dictionary.get(codonSeq.subSequence(i, i+3)));  //Test line
		}
		return aminoSeq;
	}
	/**
	 * GET METHOD
	 * @return the dictionary
	 */
	public  Map<String, String> getDictionary() { return dictionary; }
}

