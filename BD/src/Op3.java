
import java.util.Scanner;
import java.sql.*;

public class Op3 {

	private String titolo;
	private String descrizione;
	private String settore;
	private String file;

	public Op3(Scanner in) {
		in.nextLine();
		System.out.print("Inserisci il titolo :");
		titolo = in.nextLine();
		System.out.print("Inserisci una descrizione:");
		descrizione = in.nextLine();
		System.out.print("Inserisci il settore di appartenenza:");
		settore = in.nextLine();
		
		System.out.print("Inserisci il nome del file con estensione:");
		file = in.nextLine();

	}

	public void execute(Connection con) throws Exception {

		CallableStatement st = con.prepareCall(
				"call ins_foto('" + titolo + "','" + settore + "','" + descrizione + "','" + file + "');");
		st.execute();
	}
}
