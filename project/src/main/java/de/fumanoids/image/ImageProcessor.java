package de.fumanoids.image;

import java.awt.image.BufferedImage;

enum Colors {
	GREEN, YELLOW, WHITE, NONE
};

public class ImageProcessor {

	private int green[] = { 20, 60, 40, 40, 100, 90 };
	private int white[] = { 150, 150, 150, 250, 250, 250 };
	private int yellow[] = { 100, 100, 0, 160, 160, 60 };

	public void deskew(LocImage image) {
		// Folgender Code entzerrt die Fisheye-Linse, welche die orthograpischse
		// Abbildungsfunktion r = f *sin(theta) verwendet.

		BufferedImage new_image = new BufferedImage(image.getWidth(),
				image.getHeight(), BufferedImage.TYPE_INT_RGB);

		for (int y = 0; y < image.getHeight(); ++y) {
			for (int x = 0; x < image.getWidth(); ++x) {

				// ((IMAGETYPE*) Vision::getInstance().image)->getPixelAsRGB(x,
				// y, &red, &green, &blue);
				int rgb = image.getImage().getRGB(x, y);

				int distX = x - image.getCenterX();
				int distY = y - image.getCenterY();
				int xUndistorted = (int) (x * Math.tan(Math.asin(Math
						.sqrt(distX * distX) / image.getF())));
				int yUndistorted = (int) (y * Math.tan(Math.asin(Math
						.sqrt(distY * distY) / image.getF())));
				// double r = Math.sqrt(distX * distX + distY * distY);
				// int f = image.getF();
				//
				// double alpha = Math.atan2(distY, distX);
				// double tmp = r/f;
				// if (tmp > 0.8)
				// continue;
				// double theta = Math.asin(r / f);
				//
				// double rUndistorted = (f * Math.tan(theta))/10;
				//
				// double xUndistorted_d = image.getCenterX() + rUndistorted *
				// Math.cos(alpha);
				// double yUndistorted_d = image.getCenterY() + rUndistorted *
				// Math.sin(alpha);
				// int xUndistorted = (int)xUndistorted_d;
				// int yUndistorted = (int)yUndistorted_d;
				if (xUndistorted < 640 && yUndistorted < 480)
					new_image.setRGB(xUndistorted, yUndistorted, rgb);

			}
		}
		image.setImage(new_image);
	}

	public void reduce(LocImage image) {
		for (int y = 3; y < image.getHeight(); ++y) {
			for (int x = 0; x < image.getWidth(); ++x) {
				switch (classifyColor(image.getPixelArray(x, y))) {
				case WHITE:
					image.getImage().setRGB(x, y, (0xaaffffff));
					break;
				case GREEN:
					image.getImage().setRGB(x, y, (200 << 8));
					break;
				case YELLOW:
					image.getImage().setRGB(x, y, (0xaaffff00));
					break;
				case NONE:
					image.getImage().setRGB(x, y, (0));
					break;
				default:
					break;
				}
			}
		}
		for (int y = 0; y < image.getHeight(); ++y) {
			for (int x = 0; x < image.getWidth(); ++x) {
				
			}
		}

	}

	private Colors classifyColor(int[] rgb) {
		if (rgb[0] < 15 || rgb[1] < 15 || rgb[2] < 15)
			return Colors.NONE;
		else if (rgb[0] < 50 && rgb[2] < 80)
			return Colors.GREEN;
		else if (rgb[2] > 90 && rgb[0]>90 && rgb[1]>90)
			return Colors.WHITE;
//		else if (rgb[2] < 100)
//			return Colors.YELLOW;
		return Colors.NONE;
	}
}
