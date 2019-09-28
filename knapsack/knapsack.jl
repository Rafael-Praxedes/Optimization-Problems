function knapsack(n, weights, values, capacity)
    
    println("Creating the model...")

    # Creating Model
    model = Model(with_optimizer(Cbc.Optimizer, logLevel = 0))
    
    # Defining variables
    @variable(model, x[j = 1:n], Bin)

    #Defining objective function
    @objective(model, Max, sum(values[j]*x[j] for j in 1:n))

    #Defining constraints 
    @constraint(model, sum(weights[j]*x[j] for j in 1:n) <= capacity)

    println("Solving the model...")
    optimize!(model)

    status = termination_status(model)
    if status != MOI.OPTIMAL
        println("status: $status")
    end

    println("Optimal solution value is: ", JuMP.objective_value(model))
    println("Solution is:")
    
    for j in 1:n
        print("x[$j] = ", JuMP.value(x[j]))
        print(" ")
    end
    print("\n")    
end

