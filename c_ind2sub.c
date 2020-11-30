#include "mex.h"
#include "math.h"


void c_ind2sub(
double dogsc,
double *h, int h_width, int h_height,

double *result_SC1,
double *result_SUB1
)
{
int i;
int max = h_width*h_height;
for (i=0; i<max; i++) {
  double quotient;
  double remainder;
  if (h[i]) {
    quotient = floor ((h[i]-1)/dogsc);
    remainder = h[i] - quotient*dogsc;
    quotient += 1; /* because matlab's indices start at 1 */
  }
  else {
    quotient = remainder = 0;
  }
  result_SC1[i]  = remainder;
  result_SUB1[i] = quotient;
 }
}


/* The gateway routine */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
double dogsc;
double *h;
double *result_SC1;
double *result_SUB1;

  /*  Check for proper number of arguments. */
  /* NOTE: You do not need an else statement when using
     mexErrMsgTxt within an if statement. It will never
     get to the else statement if mexErrMsgTxt is executed.
     (mexErrMsgTxt breaks you out of the MEX-file.) 
  */
  if (nrhs != 2) 
    mexErrMsgTxt("2 inputs required.");
  if (nlhs != 2) 
    mexErrMsgTxt("2 outputs required.");
  
  /* Check to make sure the first input argument is a scalar. */
  if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      mxGetN(prhs[0])*mxGetM(prhs[0]) != 1) {
    mexErrMsgTxt("Input 1 must be a scalar.");
  }
  /* Check to make sure the second input argument is a matrix. nothing to do. */
  
  /* Get the scalar inputs. */
  dogsc = mxGetScalar(prhs[0]);
  
  /* Create a pointer to the input matrices */
  h   = mxGetPr(prhs[1]);

  /* Get the dimensions of the matrix input y. */
  int h_height = mxGetM(prhs[1]);
  int h_width  = mxGetN(prhs[1]);
  
  
  /* Set the output pointer to the output matrix. */
  plhs[0] = mxCreateDoubleMatrix(h_height, h_width, mxREAL);
  plhs[1] = mxCreateDoubleMatrix(h_height, h_width, mxREAL);
  
  /* Create a C pointer to a copy of the output matrix. */
  result_SC1  = mxGetPr(plhs[0]);
  result_SUB1 = mxGetPr(plhs[1]);
  
  /* Call the C subroutine. */
  c_ind2sub( dogsc, h, h_width, h_height, result_SC1, result_SUB1);
}
