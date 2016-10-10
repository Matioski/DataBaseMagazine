
import java.util.Scanner;
import java.sql.*;
import java.text.DateFormatSymbols;

public class Op14 {
	
	private int anno;
	private int sett;
	public Op14(Scanner in){
		
			System.out.print("Inserisci l'anno di riferimento:");
			anno=in.nextInt();
			in.nextLine();
		
			System.out.print("Inserisci inserisci il numero di settimana[1:52]:");
			sett=in.nextInt();
			
		}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call print_soc("+ anno +","+ sett+");");
		st.execute();
		ResultSet rs=st.getResultSet();
		if(rs.next()){
			System.out.println("Società pubblicate sul numero "+sett+" dell'anno "+anno+".");
			System.out.println("|"+StringUtils.center("Società",80)+"|");
			System.out.println(StringUtils.center("",82,"-"));
			rs.previous();
			while(rs.next()){
				System.out.println("|"+String.format("%-80s",rs.getString(1))+"|");
				
			}
		}
		
		else{
			System.out.println("Non ci sono inserti di società in questo numero.");
		}
		
	}
}

