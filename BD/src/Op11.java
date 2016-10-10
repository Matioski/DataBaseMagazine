
import java.util.Scanner;
import java.sql.*;

public class Op11 {
	private String società;
	private int anno;
	
	private int ind;
	private int sett;
	private int imp;
	private int numPag;
	
	public Op11(Scanner in){
		in.nextLine();
		System.out.print("Inserisci il nome della società:");
		società=in.nextLine();
		System.out.print("Inserisci l'indice dell'inserto :");
		ind=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci l'anno :");
		anno=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il numero della settimana:");
		sett=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il tipo di impaginazione (1='intera',2='mezza',3='quarto',4='marquette'):");
		imp=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci numero della pagina:");
		numPag=in.nextInt();
	
		
		
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call pubblica_ins('"+ società+"',"+ ind+","+ anno +","+ sett +","+ imp+","+ numPag +");");
		st.execute();
	}
}
