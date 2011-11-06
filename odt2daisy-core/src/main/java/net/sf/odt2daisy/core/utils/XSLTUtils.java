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
import java.util.List;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 * TODO: class description
 *
 * @version $Rev$ $LastChangedDate$
 * @author Vincent SPIEWAK
 */
public class XSLTUtils {

  //Set saxon as transformer.
  //System.setProperty("javax.xml.transform.TransformerFactory",
  //        "net.sf.saxon.TransformerFactoryImpl");

  /**
   * Simple transformation method.
   * @param sourceFile - Absolute path to source xml file.
   * @param xsltFile - Absolute path to xslt file.
   * @param resultFile - File/Directory where you want to put resulting files.
   */
  public static void transform(
          String sourceFile,
          String xsltFile,
          String resultFile) {

                transform(sourceFile, xsltFile, resultFile, null, null);
  }

  public static void transform(
          String sourceFile,
          String xsltFile,
          String resultFile,
          List<String> paramNames,
          List<Object> paramValues) {

    TransformerFactory tFactory = TransformerFactory.newInstance();
    try {

      Transformer transformer =
              tFactory.newTransformer(new StreamSource(xsltFile));

      if(paramNames != null){
        for(int i=0; i<paramNames.size(); i++){
          transformer.setParameter(paramNames.get(i), paramValues.get(i));
        }
      }
      
      transformer.transform(new StreamSource(sourceFile),
              new StreamResult(resultFile));

//      Controller control = (Controller) transformer;
//      control.setMessageEmitter(new MessageEmitter());
//      Emitter mesgEm = (Emitter) control.getMessageEmitter();


    } catch (Exception e) {
      e.printStackTrace();
    }
  }

}
