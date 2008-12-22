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

using namespace std;
%}

%apply float { Real };

%typemap(in,
         fragment="NumPy_Fragments") MatrixXR {
    int newObject;
    PyArrayObject * in_array = obj_to_array_contiguous_allow_conversion($input, PyArray_FLOAT, &newObject);

    if( in_array == NULL ){
      PyErr_SetString(PyExc_ValueError,
                      "array must be of type float (dtype = 'float32')");
      
      return NULL;
    }
    
    int dims[] = {1, 2};
    require_dimensions_n(in_array, dims, 2);

    int in_rows;
    int in_cols;

    if(array_numdims(in_array) == 2){

      in_rows = array_size(in_array, 0);
      in_cols = array_size(in_array, 1);

    }else{

      in_rows = 1;
      in_cols = array_size(in_array, 0);

    }

    // prepare the input array  
    Real* in_data = (Real*)array_data(in_array);
    MatrixXR in_matrix = Eigen::Map<MatrixXRscipy>(in_data, in_rows, in_cols);

    $1.set(in_matrix);
}

%typemap(in,
         fragment="NumPy_Fragments") MatrixXC {
    int newObject;
    PyArrayObject * in_array = obj_to_array_contiguous_allow_conversion($input, PyArray_CFLOAT, &newObject);
    
    if( in_array == NULL ){
      PyErr_SetString(PyExc_ValueError,
                      "array must be of type complex float (dtype = 'complex64')");
      
      return NULL;
    }

    int dims[] = {1, 2};
    require_dimensions_n(in_array, dims, 2);

    int in_rows;
    int in_cols;

    if(array_numdims(in_array) == 2){

      in_rows = array_size(in_array, 0);
      in_cols = array_size(in_array, 1);

    }else{

      in_rows = 1;
      in_cols = array_size(in_array, 0);

    }

    // prepare the input array  
    Complex* in_data = (Complex*)array_data(in_array);

    MatrixXC in_matrix = Eigen::Map<MatrixXCscipy>(in_data, in_rows, in_cols);

    $1.set(in_matrix);
}

%typemap(in, numinputs = 0) MatrixXR* (MatrixXR temp) {
  $1 = &temp;
}

%typemap(argout) MatrixXR* {
  // prepare resulting array
  int dims[] = {(*$1).rows(), (*$1).cols()};
  PyObject * out_array = PyArray_FromDims(2, dims, PyArray_FLOAT);

  if (out_array == NULL){
    PyErr_SetString(PyExc_ValueError,
                    "Unable to create the output array.");
    
    return NULL;
  }
  
  Real* out_data = (Real*)array_data(out_array);
  Eigen::Map<MatrixXRscipy>(out_data, dims[0], dims[1]) = (*$1);

  $result = out_array;
}

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

%module ricaudio
