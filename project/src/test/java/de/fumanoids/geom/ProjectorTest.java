/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package de.fumanoids.geom;

import Jama.Matrix;
import de.fumanoids.util.matrix.Rotation;
import static de.fumanoids.util.matrix.MatrixString.ms;

import org.junit.Test;
import static org.junit.Assert.*;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author covin
 */
public class ProjectorTest {
    private static final Logger log = LoggerFactory.getLogger(ProjectorTest.class);
   
    private final Matrix rot;
    private final Vec    t;
    private final double f;
    
    private final Vec world;
    private final Vec cam;
    
    public ProjectorTest() {
        rot   = Rotation.rot(0, -Math.PI/2, 0);
        t     = new Vec(0, 0, 1);
        log.debug("0,0,1 rot y>>{}", ms(rot.transpose().times(-1).times(t)));
        world = new Vec(2,2,2);
        cam   = new Vec(0.25, -0.5);
        f = 0.5;
    }
    
    @Test
    public void testConstructor() {
        new Projector(rot, t, f);
        
    }
    
    @Test
    public void testApply(){
        Projector p = new Projector(rot, t, f);
        
        log.info("project world: {}", ms(world));
        Vectorable v = p.apply(world);
        log.info("to: {}", v.getVectorData());
        
        assertArrayEquals(cam.getVectorData(), v.getVectorData(), 0.01);
    }
}
