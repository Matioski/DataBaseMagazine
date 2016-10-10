
import java.util.Scanner;
import java.sql.*;

public class Op4 {

	private int anno;

	public Op4(Scanner in){
		System.out.print("Inserisci l'anno:");
		anno=in.nextInt();
	
		
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call crea_num("+anno+");");
		st.execute();
		
	}
}
