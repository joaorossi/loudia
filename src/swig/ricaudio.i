/* -*- C -*-  (not really, but good for syntax highlighting) */

%{
#define SWIG_FILE_WITH_INIT
%}


%include "numpy.i"

%init %{
import_array();
%}

%{
#include <Eigen/Core>
#include <Eigen/Array>

#include <stdio.h>

#include "filter.h"
#include "dct.h"
#include "window.h"
#include "melbands.h"
#include "spectralbands.h"
#include "fft.h"
#include "mfcc.h"
#include "aok.h"
#include "meddis.h"
#include "spectralreassignment.h"
#include "spectralpeaks.h"

using namespace std;
%}

%include "typemaps.i"

%include "filter.h"
%include "dct.h"
%include "window.h"
%include "spectralbands.h"
%include "melbands.h"
%include "fft.h"
%include "mfcc.h"
%include "aok.h"
%include "meddis.h"
%include "spectralreassignment.h"
%include "spectralpeaks.h"

%module ricaudio
