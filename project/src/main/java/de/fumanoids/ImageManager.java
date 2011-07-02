/**
 * 
 */
package de.fumanoids;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import de.fumanoids.message.MsgImage;

/**
 * @author naja
 *
 */
public class ImageManager {
	
	/**
	 * Open the protobuf image from the file
	 * @param file
	 * @return protobuf image or null
	 */
	public static MsgImage.Image openImage(File file) {
		
		try {
			
			FileInputStream fis = new FileInputStream(file);
			MsgImage.Image img = MsgImage.Image.parseFrom(fis);
			if(!img.isInitialized()) {
				System.err.println("Protobuf image not initialized: " + file.getAbsolutePath());
				return null;
			}
			
			return img;
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
}
