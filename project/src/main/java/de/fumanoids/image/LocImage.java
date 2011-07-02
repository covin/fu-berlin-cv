package de.fumanoids.image;

import java.awt.image.BufferedImage;
import java.awt.*;

public class LocImage {

	private BufferedImage image; // image to display in the panel

	private int pitch, roll;
	private int centerX, centerY, f;

	// Do not use this, load image with LocImageLoader.loadLocImage(...)
	public LocImage(BufferedImage image, int width, int height, int pitch,
			int roll, int centerX, int centerY, int f) {
		this.image = image;
		this.pitch = pitch;
		this.roll = roll;
		this.centerX = centerX;
		this.centerY = centerY;
		this.f = f;
	}

	public BufferedImage getImage() {
		return image;
	}

	public void setImage(BufferedImage image) {
		this.image = image;
	}

	public int getWidth() {
		return image.getWidth();
	}

	public int getHeight() {
		return image.getHeight();
	}

	public int getPitch() {
		return pitch;
	}

	public int getRoll() {
		return roll;
	}

	public int getCenterX() {
		return centerX;
	}

	public int getCenterY() {
		return centerY;
	}

	public int getF() {
		return f;
	}

	public void toGraySpace() {
		BufferedImage image = new BufferedImage(getWidth(), getHeight(),
				BufferedImage.TYPE_BYTE_GRAY);
		java.awt.Graphics g = image.getGraphics();
		g.drawImage(this.image, 0, 0, null);
		g.dispose();
		this.image = image;

	}

	public int[] getPixelArray(int x, int y) {
		int pixel = image.getRGB(x, y);
		int[] rgb = new int[3];
		//int alpha = (pixel >> 24) & 0xff;
		rgb[0] = (pixel >> 16) & 0xff; //red
		rgb[1] = (pixel >> 8) & 0xff; //gren
		rgb[2] = (pixel) & 0xff;	// blue
		return rgb;
	}

}
