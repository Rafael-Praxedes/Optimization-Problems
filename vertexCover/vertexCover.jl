function vertexCover(n_Vertex, edges)

    println("Creating the model...")

    #Creating the model
    model = Model(with_optimizer(Cbc.Optimizer, logLevel = 0))

    # Defining variables
    @variable(model, x[i = 1:n_Vertex], Bin)

    #Defining objective function
    @objective(model, Min, sum(x[i] for i in 1:n_Vertex))

    #Defining constraint 
    @constraint(model, constraint[edge in edges], x[edge[1]] + x[edge[2]] >= 1)
    
    println("Solving the model...")
    optimize!(model)
    
    status = termination_status(model)
    if status != MOI.OPTIMAL
        println("status: $status")
    end
    
    println("Optimal solution value is: ", JuMP.objective_value(model))
    println("Solution is:")

    for i in 1:n_Vertex
        if (JuMP.value(x[i]) == 1)
            println("Vertex $i = 1")
        end
    end
end