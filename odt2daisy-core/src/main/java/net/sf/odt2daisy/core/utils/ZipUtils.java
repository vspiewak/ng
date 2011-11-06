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

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;

/**
 * TODO: class description
 *
 * @version $Rev$ $LastChangedDate$
 * @author Vincent SPIEWAK
 */
public class ZipUtils {

  public static void unzipArchive(File archive, File outputDir) throws ZipException, IOException {
      ZipFile zipfile = new ZipFile(archive);
      for (Enumeration e = zipfile.entries(); e.hasMoreElements();) {
        ZipEntry entry = (ZipEntry) e.nextElement();
        unzipEntry(zipfile, entry, outputDir);
      }
  }

  public static void unzipEntry(ZipFile zipfile, ZipEntry entry, File outputDir) throws IOException {

    if (entry.isDirectory()) {
      createDir(new File(outputDir, entry.getName()));
      return;
    }

    File outputFile = new File(outputDir, entry.getName());
    if (!outputFile.getParentFile().exists()) {
      createDir(outputFile.getParentFile());
    }

    BufferedInputStream inputStream = new BufferedInputStream(zipfile.getInputStream(entry));
    BufferedOutputStream outputStream = new BufferedOutputStream(new FileOutputStream(outputFile));

    try {
      copy(inputStream, outputStream);
    } finally {
      outputStream.close();
      inputStream.close();
    }
  }

  private static void createDir(File dir) {
    if (!dir.mkdirs() && !dir.isDirectory()) {
      throw new RuntimeException("Can not create dir " + dir);
    }
  }

  public static void copy(InputStream in, OutputStream out)
          throws IOException {

    if (in == null) {
      throw new NullPointerException("InputStream is null!");
    }

    if (out == null) {
      throw new NullPointerException("OutputStream is null");
    }

    // Transfer bytes from in to out
    byte[] buf = new byte[1024];
    int len;
    while ((len = in.read(buf)) > 0) {
      out.write(buf, 0, len);
    }

    in.close();
    out.close();

  }

}
