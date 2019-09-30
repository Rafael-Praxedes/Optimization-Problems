#= ------------------------------ Optmization Problems with Julia ------------------------------ 

    Author: Rafael Maranhão Rêgo Praxedes.

    Description: This file is a set of optmization problems that are implemented in Julia.  

    Execute Command: julia main.jl problem dataFile.txt.
        Example: julia main.jl knapsack dataKnapsack.txt.

  --------------------------------------------------------------------------------------------- =#

using JuMP, Cbc
include("knapsack/knapsack.jl")
include("boardProblem/boardProblem.jl")
include("vertexCover/vertexCover.jl")

function main(ARGS)

    problem = ARGS[1]
    fileName = ARGS[2]

    dataFile = open(string(problem, "/", fileName), "r")
    lines = readlines(dataFile)

    if (problem == "knapsack")
        weights = [parse(Int, weight) for weight in split(lines[1], " ")]
        values = [parse(Int, value) for value in split(lines[2], " ")]
        capacity = parse(Int, lines[3])

        knapsack(length(values), weights, values, capacity)
    elseif (problem == "boardProblem")
        n, m, v = [parse(Int, element) for element in split(lines[1], " ")]

        boardProblem(n, m, v)
    elseif (problem == "vertexCover")
        n_Vertex = parse(Int, lines[1])
        n_Edges = parse(Int, lines[2])

        edges = []
        for i in 1:n_Edges
            push!(edges, [parse(Int, element) for element in split(lines[2 + i], " ")])
        end

        vertexCover(n_Vertex, edges)
    else
        println("Error on second argumment of command terminal!")
    end

    close(dataFile)
end

main(ARGS)