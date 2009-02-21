/*                                                         
** Copyright (C) 2008 Ricard Marxer <email@ricardmarxer.com>
**                                                                  
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 2 of the License, or   
** (at your option) any later version.                                 
**                                                                     
** This program is distributed in the hope that it will be useful,     
** but WITHOUT ANY WARRANTY; without even the implied warranty of      
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       
** GNU General Public License for more details.                        
**                                                                     
** You should have received a copy of the GNU General Public License   
** along with this program; if not, write to the Free Software         
** Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
*/                                                                          

#ifndef ODF_H
#define ODF_H

#include "Typedefs.h"
#include "Debug.h"

#include "ODFBase.h"

class ODF {
public:
  enum ODFType {
    SPECTRAL_FLUX = 0,
    HIGH_FREQUENCY_CONTENT = 1,
    PHASE_DEVIATION = 2,
    WEIGHTED_PHASE_DEVIATION = 3,
    NORM_WEIGHTED_PHASE_DEVIATION = 4,
    MODIFIED_KULLBACK_LIEBLER = 5,
    COMPLEX_DOMAIN = 6,
    RECTIFIED_COMPLEX_DOMAIN = 7,
    CENTER_OF_GRAVITY = 8
  };

protected:
  // Internal parameters
  int _fftLength;
  ODFType _odfType;
  
  // Internal variables
  ODFBase* _odf;

public:
  ODF(int fftLength, ODFType odfType = COMPLEX_DOMAIN);
  
  ~ODF();

  void setup();

  void process(const MatrixXC& fft, MatrixXR* odfValue);

  void reset();

};

#endif  /* ODF_H */