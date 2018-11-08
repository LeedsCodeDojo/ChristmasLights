// Learn more about F# at http://fsharp.org

open System
open Xmas1000

[<EntryPoint>]
let main argv =
    
    blankGrid 
    |> off (1,1) (4,1) 
    |> on (6,1) (11,1) 
    |> printGrid


    0 // return an integer exit code
