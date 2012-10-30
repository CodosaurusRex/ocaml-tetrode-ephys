(* I want a spiketrain to 'link back' to the electrode from which the
   spiketrain originated.  Several spiketrains link back to a single
   electrode, because a single electrode records multiple cells.
   Is this a job for hash-consing? *)
open Sexplib.Std

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






















