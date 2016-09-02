## Copyright (C) 1996-2016 John W. Eaton
## Copyright (C) 2009-2010 VZLU Prague
##
## This file is part of Octave.
##
## Octave is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or (at
## your option) any later version.
##
## Octave is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn  {} {} median (@var{x})
## @deftypefnx {} {} median (@var{x}, @var{dim})
## Compute the median value of the elements of the vector @var{x}.
##
## When the elements of @var{x} are sorted, the median is defined as
## @tex
## $$
## {\rm median} (x) =
##   \cases{x(\lceil N/2\rceil), & $N$ odd;\cr
##           (x(N/2)+x(N/2+1))/2, & $N$ even.}
## $$
## @end tex
## @ifnottex
##
## @example
## @group
##               x(ceil(N/2))             N odd
## median (x) =
##              (x(N/2) + x((N/2)+1))/2   N even
## @end group
## @end example
##
## @end ifnottex
## If @var{x} is of a discrete type such as integer or logical, then
## the case of even N rounds up (or toward @code{true}).
##
## If @var{x} is a matrix, compute the median value for each column and
## return them in a row vector.
##
## If the optional @var{dim} argument is given, operate along this dimension.
## @seealso{mean, mode}
## @end deftypefn

## Author: jwe

function retval = median (x, dim)

  if (nargin != 1 && nargin != 2)
    print_usage ();
  endif

  if (! (isnumeric (x) || islogical (x)))
    error ("median: X must be a numeric vector or matrix");
  endif

  if (isempty (x))
    error ("median: X cannot be an empty matrix");
  endif

  nd = ndims (x);
  sz = size (x);
  if (nargin < 2)
    ## Find the first non-singleton dimension.
    (dim = find (sz > 1, 1)) || (dim = 1);
  else
    if (! (isscalar (dim) && dim == fix (dim) && dim > 0))
      error ("median: DIM must be an integer and a valid dimension");
    endif
  endif

  n = size (x, dim);
  k = floor ((n+1) / 2);
  if (mod (n, 2) == 1)
    retval = nth_element (x, k, dim);
  else
    retval = sum (nth_element (x, k:k+1, dim), dim, "native") / 2;
    if (islogical (x))
      retval = logical (retval);
    endif
  endif
  ## Inject NaNs where needed, to be consistent with Matlab.
  if (isfloat (x))
    retval(any (isnan (x), dim)) = NaN;
  endif

endfunction


%!test
%! x = [1, 2, 3, 4, 5, 6];
%! x2 = x';
%! y = [1, 2, 3, 4, 5, 6, 7];
%! y2 = y';
%!
%! assert (median (x) == median (x2) && median (x) == 3.5);
%! assert (median (y) == median (y2) && median (y) == 4);
%! assert (median ([x2, 2*x2]), [3.5, 7]);
%! assert (median ([y2, 3*y2]), [4, 12]);

%!assert (median (single ([1,2,3])), single (2))
%!assert (median ([1,2,NaN;4,5,6;NaN,8,9]), [NaN, 5, NaN])
%!assert (median ([1,2], 3), [1,2])

## Test multidimensional arrays (bug #35679)
%!shared a, b, x, y
%! rand ("seed", 2);
%! a = rand (2,3,4,5);
%! b = rand (3,4,6,5);
%! x = sort (a, 4);
%! y = sort (b, 3);
%!assert (median (a, 4), x(:, :, :, 3))
%!assert (median (b, 3), (y(:, :, 3, :) + y(:, :, 4, :))/2)

## Test non-floating point types
%!assert (median ([true, false]), true)
%!assert (median (uint8 ([1, 3])), uint8 (2))
%!assert (median (int8 ([1, 3, 4])), int8 (3))
%!assert (median (single ([1, 3, 4])), single (3))
%!assert (median (single ([1, 3, NaN])), single (NaN))

## Test input validation
%!error median ()
%!error median (1, 2, 3)
%!error <X must be a numeric> median ({1:5})
%!error <X cannot be an empty matrix> median ([])
%!error <DIM must be an integer> median (1, ones (2,2))
%!error <DIM must be an integer> median (1, 1.5)
%!error <DIM must be .* a valid dimension> median (1, 0)
