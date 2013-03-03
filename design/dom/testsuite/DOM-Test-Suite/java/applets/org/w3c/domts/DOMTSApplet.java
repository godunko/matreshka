/*
 * Copyright (c) 2001-2004 World Wide Web Consortium,
 * (Massachusetts Institute of Technology, Institut National de
 * Recherche en Informatique et en Automatique, Keio University). All
 * Rights Reserved. This program is distributed under the W3C's Software
 * Intellectual Property License. This program is distributed in the
 * hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE.
 * See W3C License http://www.w3.org/Consortium/Legal/ for more details.
 */

package org.w3c.domts;

import java.applet.Applet;
import java.awt.Graphics;
import java.io.Serializable;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.IOException;

/**
 *
 *    Minimalistic applet used to satisfy applet elements in
 *    HTML/XHTML test suites.  Should be compliled with JDK 1.1 or
 *    earlier for widest compatibility.
 *
 */
public class DOMTSApplet extends Applet implements Serializable {

    /**
     *   Paints DOMTS sample applet at top level of rectangle
     *
     */
    public void paint(Graphics g) {
            //Draw a Rectangle around the applet's display area.
        g.drawRect(0, 0, size().width - 1, size().height - 1);

            //Draw the current string inside the rectangle.
        g.drawString("DOMTS sample applet", 5, 15);
    }

    /**
     *   Serializes instance of object as pattern for <applet object=".."> parameter
     *
     */
    public static void main(String[] args) {
        if (args.length < 1) {
            System.out.print("Usage: java org.w3c.domts.DOMTSApplet outfile");
            System.exit(1);
        }
        try {
            FileOutputStream file = new FileOutputStream(args[0]);
            ObjectOutputStream out = new ObjectOutputStream(file);
            out.writeObject(new DOMTSApplet());
            out.flush();
            out.close();
        } catch(IOException ex) {
            ex.printStackTrace();
        }
    }
}


