
import java.util.Scanner;
import java.sql.*;
import java.text.DateFormatSymbols;

public class Op18 {
	private String settore;
	private int id;
	public Op18(Scanner in){
			in.nextLine();
			System.out.println("Inserisci il nome del settore:");
			settore=in.nextLine();
			
		
			System.out.println("Inserisci l'ID del coordinatore:");
			id=in.nextInt();
			
		}
	public void execute(Connection con)throws Exception{
		PreparedStatement rs=con.prepareStatement("UPDATE `giornale`.`settore` SET `Coordinatore`='"+id+"' WHERE `Nome`='"+settore+"';");
		//CallableStatement st=con.prepareCall("call cambia_cor('"+ settore +"',"+ id+");");
		
		int n=rs.executeUpdate();
		if(n==0)
		System.out.println("Nessuna tupla modificata.");
		
	}
}