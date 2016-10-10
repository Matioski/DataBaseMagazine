
import java.util.ArrayList;
import java.util.Scanner;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.*;

public class Op10 {

	private String titolo;

	
	public Op10(Scanner in){
		in.nextLine();
		System.out.print("Inserisci il Titolo:");
		titolo=in.nextLine();
	}
	public void execute(Connection con)throws Exception{
		
		CallableStatement st=con.prepareCall("call print_articolo('"+ titolo+"');");
		st.execute();
		String titolo;
		String sottotitolo;
		String occhiello;
		String corpo;
		ResultSet rs =st.getResultSet();
		ArrayList<BufferedImage>  foto = new ArrayList<BufferedImage>();
		ArrayList<String> tFoto = new ArrayList<String>();
		
		if(rs.next()){
					
		    	   titolo=rs.getString(1);
		    	   sottotitolo=rs.getString(2);
		    	   occhiello=rs.getString(3);
		    	   corpo=rs.getString(4);
		    	   
		    	   
		    	  if (!(rs.getString(5).equals("no"))){
		    		  
		    		  tFoto.add(rs.getString(5));
		    		 DBImage imm=new DBImage(rs.getString(5),rs.getString(6));
		    	
		    		  foto.add(imm.getImage(con));
		    		 
		    		/*  foto.add(new ImageIcon(buffer));
		    		  */
		    		   while(rs.next()){
		    			   tFoto.add(rs.getString(5));
		    			   imm=new DBImage(rs.getString(5),rs.getString(6));
		   		    	
				    		  foto.add(imm.getImage(con));
				    	  /* buffer = imm.getBytes(1,(int)imm.length());
				    	   foto.add(new ImageIcon(buffer));
				    	   */
   	                }
		    		
		    	  }
		    	  new Articolo(foto,tFoto,titolo,sottotitolo,occhiello,corpo);
		}
		else{
			System.out.println("Nessun articolo trovato.");	  
		    	  }
		    	
		System.out.println("\n");
		}
	}
