import java.awt.image.BufferedImage;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.imageio.ImageIO;

import java.sql.Blob;
import java.sql.Connection;

public class DBImage {
	private String titolo;
	private String categoria;
	public DBImage(String titolo,String categoria){
		this.titolo=titolo;
		this.categoria=categoria;
	}
	public BufferedImage getImage(Connection con) throws SQLException, IOException{
		CallableStatement st=con.prepareCall("call get_imm('"+ titolo+"','"+categoria +"');");
		st.execute();
		ResultSet rs =st.getResultSet();
		if(rs.next()){
		Blob imm;
		 imm=rs.getBlob(1);
		
		return ImageIO.read( imm.getBinaryStream());
		}
		return null;
		
	}

}
