/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package de.fumanoids.geom;

import Jama.Matrix;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import static de.fumanoids.util.matrix.MatrixString.ms;


/**
 * utility class for projection from 3D to 2D using homogeneous coordinates
 * 
 * @author covin
 */
public class Projector {
    private static final Logger log = LoggerFactory.getLogger(Projector.class);
    
    private final Matrix rot;
    private final Vec trans;
    // homogeneous projection matrix
    private final Matrix hP; 
    private final Matrix tw_c;
    
    public Projector(Matrix r, Vec t, double f) {
        this.rot   = r;
        this.trans = t;
        this.tw_c = new Matrix(4,4);
        tw_c.setMatrix(0,2,0,2,rot.transpose());
        tw_c.setMatrix(0,2,3,3,rot.transpose().times(-1).times(t));
        tw_c.set(3,3,1);
        
        double[][] hP_vals = {{f, 0, 0, 0}, 
                              {0, f, 0, 0}, 
                              {0, 0, 1, 0}};
        log.debug("create projector");
        log.debug("T-w->c: {}", ms(tw_c));
        
        this.hP = new Matrix(hP_vals);
    }
    
    /** apply initialized projector on some real world coodinates
     * 
     * @param world 3D vector
     * @return 2D image vector
     */
    public Vectorable apply(Vectorable world) {
        // steps:
        if (world.getDimension() != 3) {
            throw new IllegalArgumentException("unsupported vector dimension");
        }
        final Vec hWorld = new Vec(world.getDimension()+1);
        hWorld.setMatrix(0, 2, 0, 0, new Vec(world.getVectorData()));
        hWorld.set(3,0,1);
        final Matrix hCam = tw_c.times(hWorld);
        
        log.debug("world={}", world);
        log.debug("homogeneous world= {}", ms(hWorld));
        log.debug("homogeneous cam  = {}", ms(hCam));
        Matrix o = hP.times(hCam);
        o = o.times(-1/o.get(2, 0));
        log.debug("projection: ", ms(o));
        
        return new Vec(o.getMatrix(0, 1, 0, 0));
    }
    
}
