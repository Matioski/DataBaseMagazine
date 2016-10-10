
import java.util.Scanner;
import java.sql.*;
import java.text.DateFormatSymbols;

public class Op16 {
	private int anno;
	private int mese;
	public Op16(Scanner in){
		
			System.out.print("Inserisci l'anno di riferimento:");
			anno=in.nextInt();
			in.nextLine();
		
			System.out.print("Inserisci un mese[1:12]:");
			mese=in.nextInt();
			
		}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call print_cost_pub("+ mese +","+ anno+");");
		st.execute();
		ResultSet rs=st.getResultSet();
		if(rs.next()){
			System.out.println("Report entrate pubblicitarie mese di "+new DateFormatSymbols().getMonths()[mese-1]+" dell'anno "+anno+".");
			System.out.println("|"+StringUtils.center("Società",80)+" | "+StringUtils.center("Somma costi",11)+"|");
			System.out.println(StringUtils.center("",96,"-"));
			rs.previous();
			while(rs.next()){
				System.out.println("|"+String.format("%-80s",rs.getString(1))+" | "+String.format("%-11d",rs.getInt(2))+"|");
				
			}
		}
		
		else{
			System.out.println("Non ci sono inserti di società in questi numeri.");
		}
		
	}
}