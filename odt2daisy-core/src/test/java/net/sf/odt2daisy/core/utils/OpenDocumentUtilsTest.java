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

import java.util.ArrayList;
import junit.framework.TestCase;

/**
 *
 * @author Vincent SPIEWAK
 */
public class OpenDocumentUtilsTest extends TestCase {

  public OpenDocumentUtilsTest(String testName) {
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
   * Test of OpenDocumentUtils.getPictures method.
   */
  public void testGetPictures() throws Exception {

    String odtFile = "src/test/resources/odt/simple-image.odt";
    String picture = OpenDocumentUtils.PICTURES_FOLDER_NAME
            + "/"
            + "10000000000000A500000026FE439750.jpg";

    ArrayList<String> expResult = new ArrayList<String>();
    expResult.add(picture);

    ArrayList result = OpenDocumentUtils.getPictures(odtFile);

    assertEquals(expResult, result);

  }

//  /**
//   * Test of OpenDocumentUtils.extractPictures method.
//   */
//  public void testExtractPictures() throws Exception {
//   //TODO: implement test
//  }

}
