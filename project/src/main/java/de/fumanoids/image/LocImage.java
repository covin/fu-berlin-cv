package de.fumanoids.image;

import java.awt.image.BufferedImage;

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
}
