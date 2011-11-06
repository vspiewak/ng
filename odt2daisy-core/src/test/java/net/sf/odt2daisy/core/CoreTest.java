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
import junit.framework.TestCase;

/**
 *
 * @author Vincent SPIEWAK
 */
public class CoreTest extends TestCase {

  public CoreTest(String testName) {
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
   * Test of process method, of class Core.
   */
  public void testProcess() {
    System.out.println("process");

    File in = new File("src/test/resources/odt/simple.odt");
    File out = new File("target/simple.xml");

    Core convert = new Core(
            in,
            out);
    convert.process();

    assertTrue(out.canRead());
  }

//  /**
//   * Test of unzip method, of class Core.
//   */
//  public void testUnzip() throws Exception {
//    System.out.println("unzip");
//    Core instance = null;
//    instance.unzip();
//    // TODO review the generated test code and remove the default call to fail.
//    fail("The test case is a prototype.");
//  }
//
//  /**
//   * Test of merge method, of class Core.
//   */
//  public void testMerge() {
//    System.out.println("merge");
//    File sourceFile = null;
//    File resultFile = null;
//    Core instance = null;
//    instance.merge(sourceFile, resultFile);
//    // TODO review the generated test code and remove the default call to fail.
//    fail("The test case is a prototype.");
//  }
//
//  /**
//   * Test of pages method, of class Core.
//   */
//  public void testPages() {
//    System.out.println("pages");
//    File sourceFile = null;
//    File resultFile = null;
//    Core instance = null;
//    instance.pages(sourceFile, resultFile);
//    // TODO review the generated test code and remove the default call to fail.
//    fail("The test case is a prototype.");
//  }
//
//  /**
//   * Test of images method, of class Core.
//   */
//  public void testImages() {
//    System.out.println("images");
//    File sourceFile = null;
//    File resultFile = null;
//    Core instance = null;
//    instance.images(sourceFile, resultFile);
//    // TODO review the generated test code and remove the default call to fail.
//    fail("The test case is a prototype.");
//  }
//
//  /**
//   * Test of main method, of class Core.
//   */
//  public void testMain() {
//    System.out.println("main");
//    String[] args = null;
//    Core.main(args);
//    // TODO review the generated test code and remove the default call to fail.
//    fail("The test case is a prototype.");
//  }
//
  
}
