////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2003-2023 The Octave Project Developers
//
// See the file COPYRIGHT.md in the top-level directory of this
// distribution or <https://octave.org/copyright/>.
//
// This file is part of Octave.
//
// Octave is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Octave is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Octave; see the file COPYING.  If not, see
// <https://www.gnu.org/licenses/>.
//
////////////////////////////////////////////////////////////////////////

#if defined (HAVE_CONFIG_H)
#  include "config.h"
#endif

#include "errwarn.h"
#include "ovl.h"
#include "ov.h"
#include "ov-re-mat.h"
#include "ov-str-mat.h"
#include "ov-typeinfo.h"
#include "ops.h"

OCTAVE_BEGIN_NAMESPACE(octave)

DEFASSIGNOP (assign, char_matrix_str, octave_matrix)
{
  OCTAVE_CAST_BASE_VALUE (octave_char_matrix_str&, v1, a1);
  OCTAVE_CAST_BASE_VALUE (const octave_matrix&, v2, a2);

  octave_value tmp
    = v2.convert_to_str_internal (false, false,
                                  a1.is_sq_string () ? '\'' : '"');

  v1.assign (idx, tmp.char_array_value ());

  return octave_value ();
}

DEFNDCHARCATOP_FN (str_m, char_matrix_str, matrix, concat)

DEFNDCHARCATOP_FN (m_str, matrix, char_matrix_str, concat)

void
install_str_m_ops (octave::type_info& ti)
{
  INSTALL_ASSIGNOP_TI (ti, op_asn_eq, octave_char_matrix_str, octave_matrix,
                       assign);
  INSTALL_ASSIGNOP_TI (ti, op_asn_eq, octave_char_matrix_sq_str, octave_matrix,
                       assign);

  INSTALL_CATOP_TI (ti, octave_char_matrix_str, octave_matrix, str_m);
  INSTALL_CATOP_TI (ti, octave_char_matrix_sq_str, octave_matrix, str_m);

  INSTALL_CATOP_TI (ti, octave_matrix, octave_char_matrix_str, m_str);
  INSTALL_CATOP_TI (ti, octave_matrix, octave_char_matrix_sq_str, m_str);
}

OCTAVE_END_NAMESPACE(octave)
