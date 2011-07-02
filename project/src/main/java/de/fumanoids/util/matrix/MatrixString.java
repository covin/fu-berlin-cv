package de.fumanoids.util.matrix;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import Jama.Matrix;
import javax.annotation.Nullable;

/**
 *
 * @author wabu
 */
public class MatrixString {
        public static String ms(@Nullable Matrix m){
        if(m == null) {
            return "nil matrix";
        }
        StringBuilder sb = new StringBuilder();
        double [] data = m.getRowPackedCopy();
        for(double d : data){
            sb.append(String.format("%3e ", d));
        }
        return "[ "+sb+"]";
        }
}
