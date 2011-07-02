package de.fumanoids.image;

import java.awt.image.BufferedImage;

public class ImageProcessor {

	public void deskew(LocImage image) {
		//Folgender Code entzerrt die Fisheye-Linse, welche die orthograpischse Abbildungsfunktion r = f *sin(theta) verwendet.
		
		BufferedImage new_image = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_INT_RGB);
		
		for(int y = 0; y < image.getHeight(); ++y ) {
		  for(int x = 0; x < image.getWidth(); ++x) {

		    //((IMAGETYPE*) Vision::getInstance().image)->getPixelAsRGB(x, y, &red, &green, &blue);
			int rgb = image.getImage().getRGB(x, y);

		    int distX = x - image.getCenterX();
		    int distY = y - image.getCenterY();
		    double r = Math.sqrt(distX * distX + distY * distY);
		    int f = image.getF();
		    
		    double alpha = Math.atan2(distY, distX);
		    double theta = Math.asin(r / f);

		    double rUndistorted = f * Math.tan(theta);

		    int xUndistorted = (int)(image.getCenterX() + rUndistorted * Math.cos(alpha));
		    int yUndistorted = (int)(image.getCenterY() + rUndistorted * Math.sin(alpha));
		    new_image.setRGB(xUndistorted, yUndistorted, rgb);

		  }
		}
		image.setImage(new_image);
	}
}
