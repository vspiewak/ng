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
package net.sf.odt2daisy.core;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.zip.ZipException;
import net.sf.odt2daisy.core.utils.XSLTUtils;
import net.sf.odt2daisy.core.utils.ZipUtils;

/**
 * TODO: class description
 *
 * @version $Rev$ $LastChangedDate$
 * @author Vincent SPIEWAK
 */
public class Core {

  public final static String OS_TMP_FOLDER = System.getProperty("java.io.tmpdir");
  private File inputFile;
  private File resultFile;
  private File tmpDir;

  /**
   * TODO: constructor description
   *
   */
  public Core(File fileIn, File fileOut) {

    this.inputFile = fileIn;
    this.resultFile = fileOut;

    tmpDir = new File(OS_TMP_FOLDER + this.inputFile.getName());
    tmpDir.deleteOnExit();
    System.out.println("DEBUG: tmpDir:" + tmpDir);
  }

  public void process() {
    try {

      /* unzip the odtFile */
      unzip();

      /* merge into one xml file */
      merge(
              new File(tmpDir + File.separator + "content.xml"),
              new File(tmpDir + File.separator + "1"));

      pages(
              new File(tmpDir + File.separator + "1"),
              new File(tmpDir + File.separator + "2"));

      images(
              new File(tmpDir + File.separator + "2"),
              new File(tmpDir + File.separator + "3"));

      headers(
              new File(tmpDir + File.separator + "3"),
              new File(tmpDir + File.separator + "4"));

      blocks(
              new File(tmpDir + File.separator + "4"),
              //new File(tmpDir + File.separator + "5")
              resultFile
              );

    } catch (IOException ex) {
      Logger.getLogger(Core.class.getName()).log(Level.SEVERE, null, ex);
    }

  }

  public void unzip() throws ZipException, IOException {

    ZipUtils.unzipArchive(this.inputFile, tmpDir);

  }

  public void merge(File sourceFile, File resultFile) {

    String xsltFile = getClass().getResource("/xsl/odt_merge.xsl").toString();

    ArrayList<String> paramNames = new ArrayList<String>();
    ArrayList<Object> paramValues = new ArrayList<Object>();
    paramNames.add("baseURI");
    paramValues.add(resultFile.getParent() + File.separator);

    XSLTUtils.transform(
            sourceFile.getAbsolutePath(),
            xsltFile, resultFile.getAbsolutePath(),
            paramNames,
            paramValues);

  }

  public void pages(File sourceFile, File resultFile) {
    String xsltFile = getClass().getResource("/xsl/odt_flat_page.xsl").toString();

    XSLTUtils.transform(
            sourceFile.getAbsolutePath(),
            xsltFile, resultFile.getAbsolutePath());
  }

  public void images(File sourceFile, File resultFile) {
    String xsltFile = getClass().getResource("/xsl/odt_flat_images.xsl").toString();

    XSLTUtils.transform(
            sourceFile.getAbsolutePath(),
            xsltFile, resultFile.getAbsolutePath());
  }

  public void headers(File sourceFile, File resultFile) {
    String xsltFile = getClass().getResource("/xsl/odt_flat_images.xsl").toString();

    XSLTUtils.transform(
            sourceFile.getAbsolutePath(),
            xsltFile, resultFile.getAbsolutePath());
  }

  public void blocks(File sourceFile, File resultFile) {
    String xsltFile = getClass().getResource("/xsl/odt_flat_images.xsl").toString();

    XSLTUtils.transform(
            sourceFile.getAbsolutePath(),
            xsltFile, resultFile.getAbsolutePath());
  }
}