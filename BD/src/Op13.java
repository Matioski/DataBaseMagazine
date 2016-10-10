
import java.util.Scanner;
import java.sql.*;
import java.text.DateFormatSymbols;

public class Op13 {
	
	private int paga;
	
	private int mese;
	private int anno;
	public Op13(Scanner in){
		System.out.print("Inserisci la paga per articolo:");
		paga=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il mese di riferimento[1:12]:");
		mese=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci l'anno di riferimento:");
		anno=in.nextInt();
		in.nextLine();
		
		
	}
		
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call print_retribuzione("+ paga +","+ mese +","+ anno+");");
		st.execute();
		ResultSet rs=st.getResultSet();
		if(rs.next()){
			System.out.println("Retribuzione riguardante il mese "+new DateFormatSymbols().getMonths()[mese-1]+" del "+anno+".");
			System.out.println("|"+StringUtils.center("CF",16)+" | "+StringUtils.center("Nome",30)+" | "+StringUtils.center("Cognome",30)+" | "+StringUtils.center("Retribuzione",12)+" | "+StringUtils.center("Tipo",20)+"|");
			System.out.println(StringUtils.center("",119,"-"));
			rs.previous();
			while(rs.next()){
				System.out.println("|"+String.format("%-16s",rs.getString(1))+" | "+String.format("%-30s",rs.getString(2))+" | "+String.format("%-30s",rs.getString(3))+" | "+String.format("%-12d",rs.getInt(4))+" | "+String.format("%-20s",rs.getString(5))+"|");
				
			}
		}
		else{
			System.out.println("Nessun giornalista da retribuire trovato.");
		}
	}
}
