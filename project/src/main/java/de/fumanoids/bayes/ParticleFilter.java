package de.fumanoids.bayes;

public class ParticleFilter {

	private class Particle {
		int x;
		int y;
		int orientation;
	}

	Particle[] particles;
	double[] weights;

	private void moveParticles(int delta_x, int delta_y, int delta_o) {
		for (int i = 0; i < particles.length; i++) {
			particles[i].orientation += delta_o;
			particles[i].x += delta_x;
			particles[i].y += delta_y;
		}
	}
	
	private void normalizeWeights() {
		double sum = 0;
		for (int i = 0; i < weights.length; i++) {
			sum+=weights[i];
		}
		for (int i = 0; i < weights.length; i++) {
			weights[i]/=sum;
		}
	}
	

}
