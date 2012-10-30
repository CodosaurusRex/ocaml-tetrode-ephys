(*
  Spiketrain module - represent series of spikes.

  Copyright (C) 2012 Greg Hale

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*)


type t = { trode_label: string;
           spike_times: float array } with sexp


(* json_file import: Just intended to get my data from
   matlab into ocaml.  Normally this data would be stored
   in s-expressions made by sexp
   from_json_file is very specific to one format:
   json exported from matlabcentral's jsonlab ( http://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encodedecode-json-files-in-matlaboctave)
   matlab struct array: one element per cell, trode name in
   field 'trode_name'.  Spike times in field 'time'.
*)

val from_json_file : string -> t list



















