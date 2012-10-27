(*

(* Trying to make phantom type that specifies the sort
   of string being used.  Is it actually helpful here?
   Or unnecessary / wrong use for phantom types? *)
module Sourcelabel : sig
  type 'a t
  val trainlabel : string -> [`Trainlabel] t
  val trodelabel : string -> [`Trodelabel] t
  val sessionlabel : string -> [`Sessionlabel] t
  val to_string : 'a t -> string
end = struct
  type 'a t = string
  external trainlabel :   string -> ['Trainlabel]   t = "%identity"
  external trodelabel :   string -> ['Trodelabel]   t = "%identity"
  external sessionlabel : string -> ['Sessionlabel] t = "%identity"
  external to_string : 'a t -> string = "%identity"
end

module Spikewaveform : sig
  type t : float array array 
end = struct
  type t = float array array
end

*)

(* I want a spiketrain to 'link back' to the electrode from which the
   spiketrain originated.  Several spiketrains link back to a single
   electrode, because a single electrode records multiple cells.
   Is this a job for hash-consing? *)
open Sexplib.Std

module Spiketrain : sig
  type t = { trode_label: string;
             spike_times: float array } with sexp
  val from_json_file : string -> t list
end = struct
  type t = { trode_label: string;
             spike_times : float array} with sexp
  let from_json_file filename = 
    
    let module U = Yojson.Basic.Util in
    let (|>) = U.(|>) in
    print_endline ("Opening file " ^ filename ^ "...");
    let json = Yojson.Basic.from_file filename in
    
    print_endline ("Processing...");

    let t_label js = js
           |> U.member "trode_name"
           |> U.to_string
    and s_times js = js
           |> U.member "time"
           |> U.to_list
           |> U.filter_float
    in
    let r = List.map (fun js -> 
      { trode_label = t_label js; spike_times = Array.of_list (s_times js) }  ) 
      (json |> U.member filename |> U.to_list) in
    print_endline ("Done.");
    r
end






















