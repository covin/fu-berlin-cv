/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package de.fumanoids.util.matrix;

import Jama.Matrix;

/**
 *
 * @author covin
 */
public class Rotation {

    public static Matrix rot(double x_alpha, double y_alpha, double z_alpha) {
        return rotx(x_alpha).times(
               roty(y_alpha).times(
               rotz(z_alpha)));        
    }
    
    public static Matrix rotx(double alpha) {
        final double sa = Math.sin(alpha);
        final double ca = Math.cos(alpha);

        double[][] v = {{1,  0,   0},
                        {0, ca, -sa},
                        {0, sa, ca}};
        return new Matrix(v);
    }
    
    public static Matrix roty(double alpha) {
        final double sa = Math.sin(alpha);
        final double ca = Math.cos(alpha);

        double[][] v = {{ ca,  0,-sa},
                        {  0,  1,  0},
                        { sa,  0, ca}};
        return new Matrix(v);
    }
        
    public static Matrix rotz(double alpha) {
        final double sa = Math.sin(alpha);
        final double ca = Math.cos(alpha);

        double[][] v = {{ ca, sa, 0},
                        {-sa, ca, 0},
                        {  0,  0, 1}};
        return new Matrix(v);
    }
}
