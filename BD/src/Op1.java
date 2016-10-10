
import java.util.Scanner;
import java.sql.*;

public class Op1 {
	private String cF;
	private int tipo;
	private String nome;
	private String cognome;
	private String data;
	private String indirizzo;
	private String città;
	private String settore;
	private String telefono;
	private String ruolo;
	private int retribuzione;
	private int prov;
	public Op1(Scanner in){
		System.out.print("Inserisci il tipo di giornalista (1=Interno 2=Esterno):");
		tipo=in.nextInt();
		in.nextLine();
		System.out.print("Inserisci il Codice Fiscale:");
		cF=in.nextLine();
		System.out.print("Inserisci il nome :");
		nome=in.nextLine();
		System.out.print("Inserisci il cognome:");
		cognome=in.nextLine();
		System.out.print("Inserisci la data di nascita(YYYY-MM-DD):");
		data=in.nextLine();
		System.out.print("Inserisci l'indirizzo:");
		indirizzo=in.nextLine();
		System.out.print("Inserisci la città:");
		città=in.nextLine();
		System.out.print("Inserisci il settore:");
		settore=in.nextLine();
		System.out.print("Inserisci un numero di telefono:");
		telefono=in.nextLine();
		if (tipo==1){
			System.out.print("Inserisci il ruolo:");
			ruolo=in.nextLine();
			System.out.print("Inserisci la retribuzione:");
			retribuzione=in.nextInt();
			in.nextLine();
			prov=1;
		}
		else {
			System.out.print("Inserisci la Provincia di competenza(1=NA,2=SA,3=CE,4=BE,5=AV):");
			prov=in.nextInt();
			in.nextLine();
			ruolo=null;
			retribuzione=0;
		}
		
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call ins_giornalista("+ tipo +",'"+ cF+"','"+ nome+"','"+ cognome +"','"+ data+"','"+ indirizzo +"','"+ città+"','"+ settore +"','"+ telefono +"',"+ prov +",'"+ ruolo +"',"+ retribuzione+");");
		st.execute();
	}
}
