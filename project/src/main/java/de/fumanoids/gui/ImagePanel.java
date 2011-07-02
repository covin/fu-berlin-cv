/**
 * 
 */
package de.fumanoids.gui;

import java.awt.Graphics;
import java.awt.Point;
import java.awt.color.ColorSpace;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.ComponentColorModel;
import java.awt.image.DataBuffer;
import java.awt.image.DataBufferByte;
import java.awt.image.SampleModel;
import java.awt.image.WritableRaster;
import java.util.List;
import java.util.Vector;

import javax.swing.JPanel;

import com.google.protobuf.ByteString;

import de.fumanoids.image.LocImage;
import de.fumanoids.message.MsgImage;
import de.fumanoids.message.MsgImage.ImageData;

/**
 * @author naja
 *
 */
public class ImagePanel extends JPanel {

	private static final long serialVersionUID = 5993734882222827563L;
	
	private BufferedImage image;  // image to display in the panel
	private int width, height;
	private int pitch, roll;
	private int centerX, centerY, f;
	
	/**
	 * Creates the panel from a protobuf image
	 * @param pbImage protobuf image
	 */
	public ImagePanel(MsgImage.Image pbImage) {
		super();		
		
		setImage(pbImage);
	}
	
	public ImagePanel(int width, int height) {
		super();
		
		image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		setSize(width, height);
	}
	
	public void paintComponent(Graphics g) {
		g.drawImage(image, 0, 0, null);
	}
	
	/**
	 * 
	 * @param pbImage
	 */
	public void setImage(MsgImage.Image pbImage) {
		// list of data
		List<MsgImage.ImageData> imageData = pbImage.getImageDataList();
		
		List<ByteString> dataStrings = new Vector<ByteString>();
		width = -1;
		height = -1;
		
		// combine data
		for(int i = 0; i < imageData.size(); ++i) {
			ImageData id = pbImage.getImageData(i);
			
			if(!id.isInitialized()) {
				System.out.println("imageData not initialized");
				continue;
			}
			
			width = id.getWidth();
			height = id.getHeight();
			dataStrings.add(id.getData());
		}
		
		// set image with the new data
		image = createOpenCVCompatibleBufferedImage(width, height, ByteString.copyFrom(dataStrings).toByteArray());
		
		setSize(width, height);
		
		pitch = pbImage.getPitch();
		roll = pbImage.getRoll();
		centerX = pbImage.getCenter().getX();
		centerY = pbImage.getCenter().getY();
		f = pbImage.getCenter().getR();
	}
	
	public void setImage(LocImage image) {
		setSize(image.getWidth(), image.getHeight());
		
		pitch = image.getPitch();
		roll = image.getRoll();
		centerX = image.getCenterX();
		centerY = image.getCenterY();
		f = image.getF();
	}

	/**
	 * Creates an IplImage compatible buffered image
	 * used from {@link http://www.morethantechnical.com/2009/05/14/combining-javas-bufferedimage-and-opencvs-iplimage/}
	 * 
	 * @param w width of image
	 * @param h height of image
	 * @param data data of image
	 * @return created buffered image
	 */
	private BufferedImage createOpenCVCompatibleBufferedImage(int w, int h, byte[] data) {
		ComponentColorModel cm = new ComponentColorModel(
				ColorSpace.getInstance(ColorSpace.CS_sRGB), false, // no alpha																// channel
				false, // not premultiplied
				ColorModel.OPAQUE, DataBuffer.TYPE_BYTE); // important - data in
															// the buffer is
															// saved by the byte

		SampleModel sm = cm.createCompatibleSampleModel(w, h);
		DataBufferByte db = new DataBufferByte(data, w * h * 3); // 3 channels buffer
		WritableRaster r = WritableRaster.createWritableRaster(sm, db,
				new Point(0, 0));
		BufferedImage bm = new BufferedImage(cm, r, false, null);
		return bm;
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
	
	public int getFocalLength() {
		return f;
	}
}
