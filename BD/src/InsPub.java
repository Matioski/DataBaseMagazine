import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Scanner;

public class InsPub {
	private String soc;
	private String file;
	private int pub;
	private int costo;
	private String prodotto;
	public InsPub(Scanner in) {
		in.nextLine();
		System.out.print("Inserisci il nome della società :");
		soc = in.nextLine();
		System.out.print("Inserisci il nome del file(il file deve essere già presente nel server):");
		file = in.nextLine();
		System.out.print("Inserisci il nuomero di pubblicazione dovute:");
		pub = in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il costo per pubblicazione:");
		costo = in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il nome del prodotto:");
		prodotto = in.nextLine();

	}
	public void execute(Connection con) throws SQLException{
		CallableStatement st = con.prepareCall(
				"call ins_pub('" + soc + "','" + file + "'," + pub + "," + costo +",'"+prodotto+ "');");
		st.execute();
	}
}
