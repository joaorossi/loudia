#!/usr/bin/env python

# Create input
import scipy
import scipy.signal
import ricaudio

plot = True

order = 4
freq = 0.3
rp = 0.05
fs = 8000

rc = ricaudio.Chebyshev( 1, order, freq, rp, fs )
sc_b, sc_a = scipy.signal.cheby1(order, rp, freq, btype='low', analog=0, output='ba')

rc_b = rc.b().T
rc_a = rc.a().T

print scipy.allclose(sc_b, rc_b) and scipy.allclose(sc_a, rc_a)

if plot:
    # Create the omega array
    npoints = 1000
    w = scipy.arange(-scipy.pi, scipy.pi, 2*scipy.pi/(npoints), dtype = 'f4')

    # Calculate the frequency response
    d = ricaudio.freqz(rc_b.T, rc_a.T, w)

    import pylab

    pylab.subplot(2,1,1)
    pylab.plot(w, abs(d[:,0]))
    pylab.title('Magnitude of the Frequency Response')
    
    pylab.subplot(2,1,2)
    pylab.plot(w, scipy.angle(d[:,0]))
    pylab.title('Angle of the Frequency Response')
    
    pylab.show()



