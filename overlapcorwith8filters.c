
/* Called from within rocodecWithFovealModel.m  */
/* SAME AS OVERLAPCOR.C, ONLY THE FORMER IS WITH 4 FILTERS, AND THIS ONE IS DONE FOR 8 FILTERS*/


#include "mex.h"

#define min(x,y) (((x)<(y))?(x):(y))
#define max(x,y) (((x)>(y))?(x):(y))

void
overlapcorwith8filters (  double ma,
	      double na,
	      double i,
	      double lencfs,
	      double *SC1,
	      double *SUB1,
	      double *I1, int I1_width, int I1_height,
	      double *J1, int J1_width, int J1_height,
	      double *cfs,
	      double *B_1, int B_1_width,
	      double *B_2, int B_2_width,
	      double *B_3, int B_3_width,
	      double *B_4, int B_4_width,
	      double *B_5, int B_5_width,
	      double *B_6, int B_6_width,
	      double *B_7, int B_7_width,
	      double *B_8, int B_8_width,
	      
	      double *cfthr1)
{
 int i_int = i;/**** because array subscript must be an integer but i is passed as a double from matlab***/
  int count2 = 0;
  double *B1, row1, col1;
  double *B2, row2, col2;
  int mb1, nb1, mb2, nb2;
  int ind;
  
  int index_b1 = (SC1[i_int - 1] - 1) + (SUB1[i_int - 1] - 1) * I1_height;
	  row1 = I1[index_b1];
	  index_b1 = (SC1[i_int - 1] - 1) + (SUB1[i_int - 1] - 1) * J1_height;
	  col1 = J1[index_b1];
	  index_b1 = SC1[i_int - 1];


	  switch (index_b1)
	    {
	    case 1:
	      B1 = B_1;
	      mb1 = nb1 = B_1_width;
	      break;
	    case 2:
	      B1 = B_2;
	      mb1 = nb1 = B_2_width;
	      break;
	    case 3:
	      B1 = B_3;
	      mb1 = nb1 = B_3_width;
	      break;
	    case 4:
	      B1 = B_4;
	      mb1 = nb1 = B_4_width;
	      break;
	      
	      case 5:
	      B1 = B_5;
	      mb1 = nb1 = B_5_width;
	      break;
	      
	      case 6:
	      B1 = B_6;
	      mb1 = nb1 = B_6_width;
	      break;
	      
	     case 7:
	      B1 = B_7;
	      mb1 = nb1 = B_7_width;
	      break;
	      
	      case 8:
	      B1 = B_8;
	      mb1 = nb1 = B_8_width;
	      break; 
	      
	   
	    default:
	      mexErrMsgTxt ("index must be within 1 and 8.");
	      
	    } /* end of switch loop */


  for (ind = (i_int + 1); ind <= lencfs; ind++)
    {
      count2 = count2 + 1;
      
	  int index = (SC1[ind - 1] - 1) + (SUB1[ind - 1] - 1) * I1_height;
	  row2 = I1[index];
	  index = (SC1[ind - 1] - 1) + (SUB1[ind - 1] - 1) * J1_height;
	  col2 = J1[index];
	  index = SC1[ind - 1];


	  switch (index)
	    {
	    case 1:
	      B2 = B_1;
	      mb2 = nb2 = B_1_width;
	      break;
	    case 2:
	      B2 = B_2;
	      mb2 = nb2 = B_2_width;
	      break;
	    case 3:
	      B2 = B_3;
	      mb2 = nb2 = B_3_width;
	      break;
	    case 4:
	      B2 = B_4;
	      mb2 = nb2 = B_4_width;
	      break;
	      
	    case 5:
	      B2 = B_5;
	      mb2 = nb2 = B_5_width;
	      break;
	      
	    case 6:
	      B2 = B_6;
	      mb2 = nb2 = B_6_width;
	      break;
	      
	      case 7:
	      B2 = B_7;
	      mb2 = nb2 = B_7_width;
	      break;
	      
	    case 8:
	      B2 = B_8;
	      mb2 = nb2 = B_8_width;
	      break;
	   
	    default:
	      mexErrMsgTxt ("index must be within 1 and 6.");
	      
	    } /* end of switch loop */
	



      double psf = 0;


      double minrow1 = row1 - (mb1 - 1) / 2;
      double maxrow1 = min (row1 + (mb1 - 1) / 2, ma);
      double mincol1 = col1 - (nb1 - 1) / 2;
      double maxcol1 = min (col1 + (nb1 - 1) / 2, na);
      double shiftrow1, shiftcol1;
      if (minrow1 < 1)
	{
	  shiftrow1 = 1 - minrow1;
	  minrow1 = 1;
	}
      else
	shiftrow1 = 0;

      if (mincol1 < 1)
	{
	  shiftcol1 = 1 - mincol1;
	  mincol1 = 1;
	}
      else
	shiftcol1 = 0;

      double minrow2 = row2 - (mb2 - 1) / 2;
      double maxrow2 = min (row2 + (mb2 - 1) / 2, ma);
      double mincol2 = col2 - (nb2 - 1) / 2;
      double maxcol2 = min (col2 + (nb2 - 1) / 2, na);
      double shiftrow2, shiftcol2;
      if (minrow2 < 1)
	{
	  shiftrow2 = 1 - minrow2;
	  minrow2 = 1;
	}
      else
	shiftrow2 = 0;

      if (mincol2 < 1)
	{
	  shiftcol2 = 1 - mincol2;
	  mincol2 = 1;
	}
      else
	shiftcol2 = 0;


      double rowloopstart = max (minrow1, minrow2);
      double rowloopend = min (maxrow1, maxrow2);
      double colloopstart = max (mincol1, mincol2);
      double colloopend = min (maxcol1, maxcol2);

      int r, c;
      for (r = rowloopstart; r <= rowloopend; r++)
	{
	  for (c = colloopstart; c <= colloopend; c++)
	    {
	      int r1 = r - minrow1 + shiftrow1;
	      int c1 = c - mincol1 + shiftcol1;
	      int r2 = r - minrow2 + shiftrow2;
	      int c2 = c - mincol2 + shiftcol2;
	     
		psf += B1[r1 + c1 * mb1] * B2[r2 + c2 * mb2];
	    }
	}

      cfthr1[count2 - 1] = cfs[ind - 1] - (cfs[i_int - 1] * psf);

    }
} 

/* The gateway routine */
void
mexFunction (int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[])
{ double ma;
  double na;
  double i;
  double lencfs;
  double *SC1;
  double *SUB1;
  double *I1;
  double *J1;
  double *cfs;
  double *B_1;
  double *B_2;
  double *B_3;
  double *B_4;
  double *B_5;
  double *B_6;
  double *B_7;
  double *B_8;
  double *result;

  /*  Check for proper number of arguments. */
  /* NOTE: You do not need an else statement when using
     mexErrMsgTxt within an if statement. It will never
     get to the else statement if mexErrMsgTxt is executed.
     (mexErrMsgTxt breaks you out of the MEX-file.) 
   */
  if (nrhs != 17)
    mexErrMsgTxt ("17 inputs required.");
  if (nlhs != 1)
    mexErrMsgTxt ("One output required.");

/* Check to make sure the first input argument is a scalar. */
  if (!mxIsDouble (prhs[0]) || mxIsComplex (prhs[0]) ||
      mxGetN (prhs[0]) * mxGetM (prhs[0]) != 1) 
    {
      mexErrMsgTxt ("Input 1 must be a scalar.");
    }

  /* Check to make sure the second input argument is a scalar. */
  if (!mxIsDouble (prhs[1]) || mxIsComplex (prhs[1]) ||
      mxGetN (prhs[1]) * mxGetM (prhs[1]) != 1)
    {
      mexErrMsgTxt ("Input 2 must be a scalar.");
    }
  /* Check to make sure the third input argument is a scalar. */
  if (!mxIsDouble (prhs[2]) || mxIsComplex (prhs[2]) ||
      mxGetN (prhs[2]) * mxGetM (prhs[2]) != 1)
    {
      mexErrMsgTxt ("Input 3 must be a scalar.");
    }
  /* Check to make sure the fourth input argument is a scalar */
    if (!mxIsDouble (prhs[3]) || mxIsComplex (prhs[3]) ||
      mxGetN (prhs[3]) * mxGetM (prhs[3]) != 1)
    {
      mexErrMsgTxt ("Input 4 must be a scalar.");
    }

  
  
   /* Get the scalar inputs. */
 
  ma = mxGetScalar (prhs[0]);
  na = mxGetScalar (prhs[1]);
  i = mxGetScalar (prhs[2]);
  lencfs = mxGetScalar (prhs[3]);

  /* Create a pointer to the input matrices */
 
  SC1 = mxGetPr (prhs[4]);
  SUB1 = mxGetPr (prhs[5]);
  I1 = mxGetPr (prhs[6]);
  J1 = mxGetPr (prhs[7]);
  cfs = mxGetPr (prhs[8]);
  B_1 = mxGetPr (prhs[9]);
  B_2 = mxGetPr (prhs[10]);
  B_3 = mxGetPr (prhs[11]);
  B_4 = mxGetPr (prhs[12]);
  B_5 = mxGetPr (prhs[13]);
  B_6 = mxGetPr (prhs[14]);
  B_7 = mxGetPr (prhs[15]);
  B_8 = mxGetPr (prhs[16]);

  /* Get the dimensions of the matrix input y. */
 
  int I1_width = mxGetN (prhs[6]);
  int I1_height = mxGetM (prhs[6]);
  int J1_width = mxGetN (prhs[7]);
  int J1_height = mxGetM (prhs[7]);
  int B_1_width = mxGetN (prhs[9]);
  int B_2_width = mxGetN (prhs[10]);
  int B_3_width = mxGetN (prhs[11]);
  int B_4_width = mxGetN (prhs[12]);
  int B_5_width = mxGetN (prhs[13]);
  int B_6_width = mxGetN (prhs[14]);
  int B_7_width = mxGetN (prhs[15]);
  int B_8_width = mxGetN (prhs[16]);



  /* Set the output pointer to the output matrix. */
  plhs[0] = mxCreateDoubleMatrix (1, lencfs - i, mxREAL);

  /* Create a C pointer to a copy of the output matrix. */
  result = mxGetPr (plhs[0]);

  /* Call the C subroutine. */
  overlapcorwith8filters(		
		 
		 ma,
		 na,
		 i,
		 lencfs,
		 SC1,
		 SUB1,
		 I1, I1_width, I1_height,
		 J1, J1_width, J1_height,
		 cfs,
		 B_1, B_1_width,
		 B_2, B_2_width,
		 B_3, B_3_width,
		 B_4, B_4_width, 
		 B_5, B_5_width,
		 B_6, B_6_width, 
		 B_7, B_7_width,
		 B_8, B_8_width, 
		 result);
}
