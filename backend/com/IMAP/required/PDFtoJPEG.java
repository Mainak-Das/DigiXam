package com.IMAP.required;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;

@SuppressWarnings("unchecked")
public class PDFtoJPEG {
	public String[] pdfToImg(String file, String path) {
		try {
			String sourceDir = file;
			String destinationDir = path;

			File sourceFile = new File(sourceDir);
			File destinationFile = new File(destinationDir);
			System.out.println(sourceDir);
			if (!destinationFile.exists()) {
				destinationFile.mkdir();
				System.out.println("Folder Created -> " + destinationFile.getAbsolutePath());
			}
			if (sourceFile.exists()) {

				System.out.println("Images copied to Folder: " + destinationFile.getName());
				PDDocument document = PDDocument.load(sourceDir);
				List<PDPage> list = document.getDocumentCatalog().getAllPages();
				System.out.println("Total files to be converted -> " + list.size());
				String[] s = new String[list.size()];
				String fileName = sourceFile.getName().replace(".pdf", "");
				int pageNumber = 1;
				int i = 0;
				File outputfile = null;
				for (PDPage page : list) {
					BufferedImage image = page.convertToImage();
					outputfile = new File(destinationDir + File.separatorChar + fileName + "_" + pageNumber + ".png");
					System.out.println("Image Created -> " + outputfile.getName());

					//SimpleDateFormat sdf = new SimpleDateFormat("dd_MM_yyyyy");

					//s[i] = sdf.format(new Date()) + "_" + outputfile.getName();
					s[i] = outputfile.getName();
					ImageIO.write(image, "png", outputfile);
					i++;
					pageNumber++;
				}
				document.close();
				System.out.println(Arrays.toString(s));
				System.out.println("Converted Images are saved at -> " + destinationFile.getAbsolutePath());
				return s;
			} else {
				System.err.println(sourceFile.getName() + " File not exists");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}