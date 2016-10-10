

import java.util.Scanner;
import java.sql.*;

public class Op8 {

	private int anno;
	private int sett;

	
	public Op8(Scanner in){
		in=in.reset();
		System.out.print("Inserisci l'anno :");
		anno=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il numero della settimana:");
		sett=in.nextInt();
		in.nextLine();
		
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call print_numero("+ anno+","+ sett +");");
		st.execute();
		
		ResultSet rs =st.getResultSet();
		if(rs.next()){
			System.out.println("Articoli presenti sul numero "+sett+" dell'anno "+anno+".");
			System.out.println("|"+StringUtils.center("Titolo",110)+" | "+StringUtils.center("Impaginazione",13)+" | "+StringUtils.center("Pagina",6)+"|");
			System.out.println(StringUtils.center("",137,"-"));
			rs.previous();
			while(rs.next()){
				System.out.println("|"+String.format("%-110s",rs.getString(1))+" | "+String.format("%-13s",rs.getString(2))+" | "+String.format("%-6d",rs.getInt(3))+"|");
				
			       }
		System.out.println("\n");
		}
		else{
			System.out.println("Nessun articolo presente.");
		}
	}
	
}