import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.swing.JPanel;

public class ImagePanel extends JPanel{

private BufferedImage image;

public ImagePanel(BufferedImage image) {
this.image=image;
}

@Override
protected void paintComponent(Graphics g) {
    super.paintComponent(g);
   // see javadoc for more info on the parameters   
    g.drawImage(image, 0, 0, this.getWidth(), this.getHeight(), null);
}

}