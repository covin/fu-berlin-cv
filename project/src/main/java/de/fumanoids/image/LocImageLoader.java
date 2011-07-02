package de.fumanoids.image;

import java.awt.Point;
import java.awt.color.ColorSpace;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.ComponentColorModel;
import java.awt.image.DataBuffer;
import java.awt.image.DataBufferByte;
import java.awt.image.SampleModel;
import java.awt.image.WritableRaster;
import java.io.File;
import java.util.List;
import java.util.Vector;

import com.google.protobuf.ByteString;

import de.fumanoids.ImageManager;
import de.fumanoids.message.MsgImage;
import de.fumanoids.message.MsgImage.ImageData;

public class LocImageLoader {

	public static LocImage loadLocImage(File file) {

		MsgImage.Image pbImage = ImageManager.openImage(file);
		// list of data
		List<MsgImage.ImageData> imageData = pbImage.getImageDataList();

		List<ByteString> dataStrings = new Vector<ByteString>();
		int width = -1;
		int height = -1;

		// combine data
		for (int i = 0; i < imageData.size(); ++i) {
			ImageData id = pbImage.getImageData(i);

			if (!id.isInitialized()) {
				System.out.println("imageData not initialized");
				continue;
			}

			width = id.getWidth();
			height = id.getHeight();
			dataStrings.add(id.getData());
		}

		// set image with the new data
		BufferedImage image = createOpenCVCompatibleBufferedImage(width,
				height, ByteString.copyFrom(dataStrings).toByteArray());
		int pitch = pbImage.getPitch();
		int roll = pbImage.getRoll();
		int centerX = pbImage.getCenter().getX();
		int centerY = pbImage.getCenter().getY();
		int f = pbImage.getCenter().getR();
		LocImage img = new LocImage(image, width, height, pitch, roll, centerX,
				centerY, f);
		return img;
	}

	private static BufferedImage createOpenCVCompatibleBufferedImage(int w,
			int h, byte[] data) {
		ComponentColorModel cm = new ComponentColorModel(
				ColorSpace.getInstance(ColorSpace.CS_sRGB), false, // no alpha
																	// //
																	// channel
				false, // not premultiplied
				ColorModel.OPAQUE, DataBuffer.TYPE_BYTE); // important - data in
															// the buffer is
															// saved by the byte

		SampleModel sm = cm.createCompatibleSampleModel(w, h);
		DataBufferByte db = new DataBufferByte(data, w * h * 3); // 3 channels
																	// buffer
		WritableRaster r = WritableRaster.createWritableRaster(sm, db,
				new Point(0, 0));
		BufferedImage bm = new BufferedImage(cm, r, false, null);
		return bm;
	}

	public static BufferedImage deskewImage(BufferedImage img) {

		// TODO Implement this bitch or find a way to work with a skewed Image
		// (better)
		return null;
	}

}
