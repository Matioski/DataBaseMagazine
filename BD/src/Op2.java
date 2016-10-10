
import java.util.Scanner;
import java.sql.*;

public class Op2 {
	private String titolo;
	
private String sottotitolo;
	private String occhiello;
	private String corpo;
	private String categoria;
	private int autore;
	
	public Op2(Scanner in){
		sottotitolo=null;
		occhiello=null;
		in.nextLine();
		System.out.print("Inserisci il Titolo:");
		titolo=in.nextLine();
		System.out.print("Inserisci il sottotitolo(premi invio se non presente) :");
		sottotitolo=in.nextLine();
		System.out.print("Inserisci il occhiello(premi invio se non presente):");
		occhiello=in.nextLine();
		System.out.print("Inserisci il corpo (inserire 3 spazi per inserire new line):");
		corpo=in.nextLine();
		System.out.print("Inserisci il settore:");
		categoria=in.nextLine();
		System.out.print("Inserisci il codice giornalista:");
		autore=in.nextInt();
		in.nextLine();		
	}
	public void execute(Connection con)throws Exception{
		corpo.replace("   ", "\n");
		CallableStatement st=con.prepareCall("call ins_articolo('"+ titolo+"','"+ sottotitolo+"','"+ occhiello +"','"+ corpo+"',"+ autore+",'"+ categoria+"');");
		st.execute();
	}
}
