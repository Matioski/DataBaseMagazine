
import java.util.Scanner;
import java.sql.*;

public class main {
	static Connection con;
	static Scanner in = new Scanner(System.in);

	public static void main(String[] args) throws Exception {

		DBConnectionPool a = new DBConnectionPool();

		con = a.getConnection();
		Statement st = con.createStatement();

		int operazione;
		String stato;
		ResultSet res;
		operazione = menu();
		while (operazione != 0) {
			switch (operazione) {
			case 1:
				Op1 oper1 = new Op1(in.reset());
				oper1.execute(con);
				con.commit();

				break;
			case 2:
				Op2 oper2 = new Op2(in.reset());
				oper2.execute(con);
				con.commit();
				break;
			case 3:
				Op3 oper3 = new Op3(in.reset());
				oper3.execute(con);
				con.commit();
				break;
			case 4:
				Op4 oper4 = new Op4(in.reset());
				oper4.execute(con);
				con.commit();
				break;
			case 5:
				InsSoc oper5 = new InsSoc(in.reset());
				oper5.execute(con);
				con.commit();

				break;
			case 6:
				InsPub oper6 = new InsPub(in.reset());
				oper6.execute(con);
				con.commit();

				break;
			case 7:
				Op7 oper7 = new Op7(in.reset());
				oper7.execute(con);
				con.commit();

				break;
			case 8:
				Op8 oper8 = new Op8(in.reset());
				oper8.execute(con);

				break;
			case 9:
				Op9 oper9 = new Op9(in.reset());
				oper9.execute(con);
				con.commit();
				break;
			case 10:
				Op10 oper10 = new Op10(in.reset());
				oper10.execute(con);

				break;
			case 11:
				Op11 oper11 = new Op11(in.reset());
				oper11.execute(con);
				con.commit();
				break;
			case 12:
				Op12 oper12 = new Op12(in.reset());
				oper12.execute(con);

				break;
			case 13:
				Op13 oper13 = new Op13(in.reset());
				oper13.execute(con);

				break;
			case 14:
				Op14 oper14 = new Op14(in.reset());
				oper14.execute(con);

				break;
			case 15:
				Op15 oper15 = new Op15();
				oper15.execute(con);

				break;
			case 16:
				Op16 oper16 = new Op16(in.reset());
				oper16.execute(con);

				break;
			case 17:
				Op17 oper17 = new Op17(in.reset());
				oper17.execute(con);

				break;
			case 18:
				Op18 oper18 = new Op18(in.reset());
				oper18.execute(con);
				con.commit();
				break;
			case 0: a.releaseConnection(con);
			        System.exit(0);

			default:
				System.out.println("Input non valido.");
				a.releaseConnection(con);
				break;

			}

			operazione = menu();
		}

	}

	private static int menu() {

		int scelta;
		System.out.println("1.Inserisci un nuovo giornalista;");
		System.out.println("2.Inserisci un nuovo articolo;");
		System.out.println("3.Inserisci una foto;");
		
		System.out.println("4.Crea i numeri per un anno;");
		System.out.println("5.Inserisci una società;");
		System.out.println("6.Inserisci un inserto;");
		System.out.println("7.Pubblica un articolo;");
		
		System.out.println("8.Visualizza il titolo degli articoli presenti in un numero;");
		System.out.println("9.Allega una foto");		
		System.out.println(
				"10.Visualizza un articolo con le relative foto(se non presenti verrà mostrato solo l'articolo);");
		System.out.println("11.Pubblica un inserto pubblicitario");
		System.out.println("12.Stampa il numero di articoli scritti in totale da un giornalista;");
		System.out.println("13.Stampa il nome di ogni giornalista con la relativa retribuzione per un determinato mese;");
		System.out.println(
				"14.Stampa il nome delle società richiedenti degli inserti pubblicitari inseriti in un numero;");
		System.out.println(
				"15.Stampa per ogni società, per ogni inserto pubblicitario le pubblicazioni dovute e quelle effettive;");
		System.out.println(
				"16.Stampa il nome delle società, la somma dei costi dei relativi inserti pubblicati nei numeri di un mese;");
		System.out.println(
				"17. Stampare  il nome delle società che hanno almeno un  inserto su tutti i numeri del mese;");
		System.out.println("18.Modifica cordinatore per un settore;");
		System.out.println("0.Esci");
		System.out.print("--Scegli l'operazione:");
		scelta = in.nextInt();
		return scelta;
	}

}
