
import java.util.Scanner;
import java.sql.*;

public class Op9 {
	private String articolo;
	private String foto;
	private String cat_foto;

	public Op9(Scanner in){
		in.nextLine();
		System.out.print("Inserisci il titolo dell'articolo :");
		articolo=in.nextLine();
		System.out.print("Inserisci il titolo dell'immagine:");
		foto=in.nextLine();
		System.out.print("Inserisci la categoria di appartenenza della foto:");
		cat_foto=in.nextLine();
				
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call Allega('" +articolo+"','"+ foto +"','"+ cat_foto+"');");
		st.execute();
	}
}
