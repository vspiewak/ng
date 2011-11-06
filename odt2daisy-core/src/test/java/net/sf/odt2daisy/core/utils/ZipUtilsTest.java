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
import junit.framework.TestCase;

/**
 *
 * @author Vincent SPIEWAK
 */
public class ZipUtilsTest extends TestCase {

  public ZipUtilsTest(String testName) {
    super(testName);
  }

  @Override
  protected void setUp() throws Exception {
    super.setUp();
  }

  @Override
  protected void tearDown() throws Exception {
    super.tearDown();
  }

  /**
   * Test of ZipUtils.unzipArchive method.
   */
  public void testUnzipArchive() throws Exception {
    
    String zipname = "src/test/resources/odt/simple.odt";
    String output = "target/simple";

    ZipUtils.unzipArchive(new File(zipname), new File(output));

    assertTrue(new File(output + "/" + "content.xml").isFile());
    assertTrue(new File(output + "/" + "manifest.rdf").isFile());
    assertTrue(new File(output + "/" + "meta.xml").isFile());
    assertTrue(new File(output + "/" + "mimetype").isFile());
    assertTrue(new File(output + "/" + "settings.xml").isFile());
    assertTrue(new File(output + "/" + "styles.xml").isFile());

    assertTrue(new File(output + "/" + "META-INF/manifest.xml").isFile());
    assertTrue(new File(output + "/" + "Thumbnails/thumbnail.png").isFile());

    assertTrue(new File(output + "/" + "Configurations2/images/Bitmaps/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/floater/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/menubar/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/popupmenu/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/progressbar/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/statusbar/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/toolbar/").isDirectory());
    assertTrue(new File(output + "/" + "Configurations2/toolpanel/").isDirectory());

  }
  
}
