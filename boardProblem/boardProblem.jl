function boardProblem(n, m, v)

    println("Creating the model...")

    #Creating the model
    model = Model(with_optimizer(Cbc.Optimizer, logLevel = 0))

    # Defining variables
    @variable(model, x[i = 1:n, j = 1:n, k = 1:m], Bin)

    #Defining objective function
    @objective(model, Min, 0)

    #Defining constraints 
    
    @constraint(model, firstConstraint[k = 1:m], sum(x[i, j, k] for i in 1:n, j in 1:n) == 1) #Each number is assigned to only one matrix position.

    @constraint(model, secondConstraint[i = 1:n], sum(k*x[i, j, k] for k in 1:m, j in 1:n) == v) #The sum of values in each matrix line is equal to v

    @constraint(model, thirdConstraint[j = 1:n], sum(k*x[i, j, k] for k in 1:m, i in 1:n) == v) #The sum of values in each matrix column is equal to v

    @constraint(model, fourthConstraint, sum(k*x[i, j, k] for k in 1:m, i in 1:n, j in 1:n if i == j) == v) #The sum of values on the main diagonal is 
                                                                                                            #equal to v 
    
    @constraint(model, fifthConstraint, sum(k*x[i, j, k] for k in 1:m, i in 1:n, j in 1:n if i + j == n + 1) == v) #The sum of values on the secundary 
                                                                                                                   #diagonal is equal to v

    @constraint(model, sixthConstraint[i = 1:n, j = 1:n], sum(x[i, j, k] for k in 1:m) == 1) #Each matrix position receive only one number
    
    println("Solving the model...")
    optimize!(model)

    status = termination_status(model)
    if status != MOI.OPTIMAL
        println("status: $status")
    end

    println("Optimal solution value is: ", JuMP.objective_value(model))
    println("Solution is:")

    for i in 1:n
        for j in 1:n
            for k in 1:m
                if (JuMP.value(x[i, j, k]) == 1)
                    println("Line $i and column $j is equal to ", k)
                end
            end
        end
    end

end