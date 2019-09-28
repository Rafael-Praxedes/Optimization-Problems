#= ------------------------------ Optmization Problems with Julia ------------------------------ 

    Author: Rafael Maranhão Rêgo Praxedes.

    Description: This file is a set of optmization problems that are implemented in Julia.  

    Execute Command: julia main.jl problem dataFile.txt.
        Example: julia main.jl knapsack dataKnapsack.txt.

  --------------------------------------------------------------------------------------------- =#

using JuMP, Cbc
include("knapsack/knapsack.jl")

function main(ARGS)

    problem = ARGS[1]
    fileName = ARGS[2]

    dataFile = open(string(problem, "/", fileName), "r")
    lines = readlines(dataFile)

    if(problem == "knapsack")
        weights = [parse(Int, weight) for weight in split(lines[1], " ")]
        values = [parse(Int, value) for value in split(lines[2], " ")]
        capacity = parse(Int, lines[3])

        knapsack(length(values), weights, values, capacity)
    else
        println("Error on second argumment of command terminal!")
    end

    close(dataFile)
end

main(ARGS)