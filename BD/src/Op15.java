
import java.util.Scanner;
import java.sql.*;

public class Op15 {
	
	public Op15(){
	
			
		}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call print_report_pub();");
		st.execute();
		ResultSet rs=st.getResultSet();
		if(rs.next()){
			System.out.println("Report pubblicazioni dovute edeffettive.");
			System.out.println("|"+StringUtils.center("Società",80)+" | "+StringUtils.center("Indice inserto",14)+" | "+StringUtils.center("Pubbl.Dovute",12)+" | "+StringUtils.center("Pubbl.Effett.",13)+"|");
			System.out.println(StringUtils.center("",129,"-"));
			rs.previous();
			while(rs.next()){
				System.out.println("|"+String.format("%-80s",rs.getString(1))+" | "+String.format("%-14d",rs.getInt(2))+" | "+String.format("%-14d",rs.getInt(3))+" | "+String.format("%-13d",rs.getInt(4))+"|");
				
			}
		}
		
		else{
			System.out.println("Non ci sono inserti di società.");
		}
		
	}
}
