
import java.util.Scanner;
import java.sql.*;
import java.text.DateFormatSymbols;

public class Op17 {
	private int anno;
	private int mese;
	public Op17(Scanner in){
		
			System.out.print("Inserisci l'anno di riferimento:");
			anno=in.nextInt();
			in.nextLine();
		
			System.out.print("Inserisci inserisci mese[1:12]:");
			mese=in.nextInt();
			
		}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call tutti_pub("+ anno +","+ mese+");");
		st.execute();
		ResultSet rs=st.getResultSet();
		if(rs.next()){
			System.out.println("Società smepre presenti nei numeri del mese di "+new DateFormatSymbols().getMonths()[mese-1]+" dell'anno "+anno+".");
			System.out.println("|"+StringUtils.center("Società",80)+"|");
			System.out.println(StringUtils.center("",82,"-"));
			rs.previous();
			while(rs.next()){
				System.out.println("|"+String.format("%-80s",rs.getString(1))+"|");
				
			}
		}
		
		else{
			System.out.println("Nessuna società è presente su tutti i numeri del mese.");
		}
		
	}
}