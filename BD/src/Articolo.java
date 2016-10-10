import java.awt.GridLayout;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.TitledBorder;

public class Articolo {
	public Articolo(ArrayList<BufferedImage> foto,ArrayList<String> tFoto,String titolo,String sottotitolo,String occhiello,String corpo){
		JFrame frame=new JFrame();
		if(foto.size()==0){
			JPanel titoli=new JPanel();
			titoli.setLayout(new GridLayout(4,1));
			JLabel tit=new JLabel(titolo);
			JLabel sTit=new JLabel(sottotitolo);
			JLabel occ=new JLabel(occhiello);
			JLabel cor=new JLabel("<html>"+corpo+"</html>");
			 JScrollPane scrollPane = new JScrollPane(cor);
		        scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
		        scrollPane.setBounds(50, 30, 300, 50);
			
			tit.setBorder(new TitledBorder("Titolo"));
			titoli.add(tit);
			sTit.setBorder(new TitledBorder("Sottotitolo"));
			titoli.add(sTit);
			occ.setBorder(new TitledBorder("Occhiello"));
			titoli.add(occ);
			cor.setBorder(new TitledBorder("Corpo"));
			titoli.add(scrollPane);
			frame.add(titoli);
			frame.setSize(300,400);
			frame.setVisible(true);
		}
		else{
			JPanel titoli=new JPanel();
			titoli.setLayout(new GridLayout(4,1));
			JLabel tit=new JLabel(titolo);
			JLabel sTit=new JLabel(sottotitolo);
			JLabel occ=new JLabel(occhiello);
			JLabel cor=new JLabel("<html>"+corpo+"</html>");
			 JScrollPane scrollPane = new JScrollPane(cor);
		       scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_NEVER);
		        scrollPane.setBounds(50, 30, 300, 50);
			
			tit.setBorder(new TitledBorder("Titolo"));
			titoli.add(tit);
			sTit.setBorder(new TitledBorder("Sottotitolo"));
			titoli.add(sTit);
			occ.setBorder(new TitledBorder("Occhiello"));
			titoli.add(occ);
			cor.setBorder(new TitledBorder("Corpo"));
			titoli.add(scrollPane);
			JPanel SlideShow = new JPanel(new GridLayout(2,foto.size()));
			SlideShow.setBorder(new TitledBorder("Foto"));
			
			for(int i=0;i<foto.size();i++){
				SlideShow.add(new JLabel(tFoto.get(i)));
				
				SlideShow.add(new ImagePanel(foto.get(i)));
			}
			JPanel articolo=new JPanel(new GridLayout(2,1));
			articolo.add(titoli);
			articolo.add(SlideShow);
			
			frame.setSize(300,400);
			frame.add(articolo);
			frame.setVisible(true);
		}
	}
}
