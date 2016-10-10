
import java.util.Scanner;
import java.sql.*;

public class Op12 {
	
	private int tipo;
	
	public Op12(Scanner in){
		
		System.out.print("Inserisci ID del giornalista:");
		
		tipo=in.nextInt();
		in.nextLine();
		
	}
		
	
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call `Print_#articoli`("+ tipo +");");
		st.execute();
		ResultSet rs=st.getResultSet();
		if(rs.next()){
			System.out.println("Il giornalista "+rs.getString(1)+" "+rs.getString(2)+" nato il "+ rs.getDate(3)+" con ID="+tipo+" ha scritto "+rs.getInt(4)+" articoli dal "+rs.getString(5).substring(0, 10)+".");
		}
		else System.out.println("Giornalista non presente nel database.");
	}
}
