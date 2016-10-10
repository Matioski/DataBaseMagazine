
import java.util.Scanner;
import java.sql.*;

public class Op7 {
	private String titolo;
	private int anno;
	private int sett;
	private int imp;
	private int numPag;
	
	public Op7(Scanner in){
		in.nextLine();
		System.out.print("Inserisci il Titolo:");
		titolo=in.nextLine();
		System.out.print("Inserisci l'anno :");
		anno=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il numero della settimana:");
		sett=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il tipo di impaginazione (1='spalla',2='apertura',3='civette',4='contornato):");
		imp=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci numero della pagina:");
		numPag=in.nextInt();
		
		
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call pubblica_art('"+ titolo+"',"+ anno+","+ sett +","+ imp+","+ numPag +");");
		st.execute();
	}
}
