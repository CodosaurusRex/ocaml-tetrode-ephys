type t = { trode_label: string;
           spike_time: float array;
           spike_pos: float array;
           spike_phase: float array;
           spike_vel: float array }

let from_json_file filename =
  let module U = Yojson.Basic.Util in
  let (|>) = U.(|>) in
  print_endline ("Opening file " ^ filename ^ "...");
  let json = Yojson.Basic.from_file filename in

  print_endline ("Processing... test");

  let t_label js = js
         |> U.member "comp"
         |> U.to_string  in
(*
  let s_times js = js
         |> U.member "time"
         |> U.to_list
         |> U.filter_float
  in
  let s_phases js = js
         |> U.member "theta_phase"
         |> U.to_list
         |> U.filter_float
  in
  let s_pos js = js
         |> U.member "pos_at_spike"
         |> U.to_list
         |> U.filter_float
  in 
  let s_vel js = js
         |> U.member "velocity"
         |> U.to_list
         |> U.filter_float
  in *)
  let r = List.map (fun js ->
    { trode_label = "hi" (*t_label js *); 
      spike_time = [||] (*Array.of_list (s_times js) *);
      spike_pos = [||] (*Array.of_list (s_pos js)*);
      spike_vel =  [||] (* Array.of_list (s_vel js) *);
      spike_phase = [||] (*Array.of_list (s_phases js) *)}  )
    (json |> U.member filename |> U.to_list) in
  print_endline ("Done.");
  r






















