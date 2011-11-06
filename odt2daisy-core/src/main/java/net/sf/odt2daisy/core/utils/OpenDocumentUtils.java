/*
 *  @(#) $HeadURL$        $Rev$ $LastChangedDate$
 * 
 *  Copyright (c) 1999-2011 Vincent SPIEWAK,
 *  All rights reserved.
 * 
 *  This software is the confidential and proprietary information of
 *  Vincent SPIEWAK ("Confidential Information").  You shall not
 *  disclose such Confidential Information and shall use it only in
 *  accordance with the terms of the license agreement you entered into
 *  with Vincent SPIEWAK.
 * 
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * 
 */
package net.sf.odt2daisy.core.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

/**
 * TODO: class description
 *
 * @version $Rev$ $LastChangedDate$
 * @author Vincent SPIEWAK
 */
public class OpenDocumentUtils {

  public static final String PICTURES_FOLDER_NAME = "Pictures";
  
  /*-
   * Return an ArrayList of image(s) path(s) included in the ODF file,
   * i.e. a ArrayList of Strings like 'Pictures/100000000000034300000273CAF76237.png'.
   *
   * @param odtFile The path to the ODF file.
   * @return ArrayList of image(s) path(s)
   * @throws java.io.IOException If an exceptional condition occurred while creating a ZipFile Object based on the path to the ODF file.
   */
  public static ArrayList<String> getPictures(String odtFile) throws IOException {

    ArrayList<String> ret = new ArrayList<String>();
    ZipFile zf = null;
    Enumeration<? extends ZipEntry> entries = null;

    zf = new ZipFile(odtFile);
    entries = zf.entries();

    while (entries.hasMoreElements()) {

      ZipEntry entry = (ZipEntry) entries.nextElement();

      if (entry.getName().startsWith(PICTURES_FOLDER_NAME + "/")) {
        if (!entry.isDirectory()) {
          ret.add(entry.getName());
        }

      }

    }

    return ret;

  }

  /*-
   * Extract pictures included inside an ODT file
   * outDir can be: images, images/, pics/, book/pics/, ...
   *
   * @param odtFile
   * @param outDir
   * @throws java.io.IOException
   */
  public static void extractPictures(String odtFile, String outDir) throws IOException {

    ZipFile zip = new ZipFile(odtFile);
    File dir = new File(outDir);

    ArrayList<String> pics = getPictures(odtFile);

    if (pics.size() < 1) {
      return;
    }

    if (dir.isFile()) {
      throw new IOException("Wrong argument: outDir is a file");
    }

    if (!dir.exists()) {
      dir.mkdirs();
    }

    for (int i = 0; i < pics.size(); i++) {
      copyInputStream(
              zip.getInputStream(zip.getEntry(pics.get(i))),
              new FileOutputStream(outDir + pics.get(i).substring(PICTURES_FOLDER_NAME.length())));

    }

  }

  private static void copyInputStream(InputStream in, OutputStream out)
          throws IOException {
    
    byte[] buffer = new byte[1024];
    int len;

    while ((len = in.read(buffer)) >= 0) {
      out.write(buffer, 0, len);
    }

    in.close();
    out.close();
  }

}
