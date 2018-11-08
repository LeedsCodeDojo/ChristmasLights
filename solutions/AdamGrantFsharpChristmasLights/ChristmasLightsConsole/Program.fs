// Learn more about F# at http://fsharp.org

open System
open Xmas1000

[<EntryPoint>]
let main argv =
    
//***********
//*    *    *
//*   ***   *
//*  *****  * 
//* ******* * 
//*    *    * 
//***********

    blankGrid 
    |> off (0,0) (7,11) 
    |> on (0,0) (0,11) 
    |> on (6,0) (6,11) 
    |> on (1,5) (1,5) 
    |> on (2,4) (2,6) 
    |> on (3,3) (3,7) 
    |> on (4,1) (4,9) 
    |> on (5,5) (5,5) 
    |> printGrid

    0 // return an integer exit code
