ModuleDeloopingLevelNotMoreThanN := function (M, n)
# Given A-moduule M and positive integer n, output whether dell(M) <= n.
# Note: the result of CommonDirectSummand can be false or a list.
# In the case of outputting anything other than false, should be counted as true.
local N, nM, result;
nM := NthSyzygy(M, n);
Print("Nth Syzygy is", nM, "\n");
if Dimension(nM) = 0 or IsProjectiveModule(nM) then
    Print("Results: True", "\n");
    return true;
else
    N := NthSyzygy(TransposeOfModule(NthSyzygy(TransposeOfModule(nM), n+1)), n+1);
    Print("Testing summand:", N, "\n");
    result := CommonDirectSummand(nM, N);
    Print("Results:", result , "\n");
    return IsList(result);
fi;
end;

AlgebraDeloopingLevelNotMoreThanN := function(A, n)
local results, RegA;
if n = 0 then 
    RegA := DirectSumOfQPAModules(IndecProjectiveModules(A));
    Print("Socle of A: ", Last(SocleSeries(RegA)), "\n");
    return not (0 in Last(SocleSeries(RegA)));
else
    results := List(SimpleModules(A), M -> ModuleDeloopingLevelNotMoreThanN(M, n));
    return not (false in results); 
fi;
end;

A_two := function()
    local Q, KQ;
    Q := Quiver(4, [[1,1,"delta"], [1,2,"alpha"], [2,3,"beta"], [4,2,"gamma"]]);
    KQ := PathAlgebra(Rationals,Q);;
    AssignGeneratorVariables(KQ);
    return KQ/[alpha*beta, gamma*beta, delta*alpha, delta*delta];
    end;
A_three := function()
    local Q, KQ;
    Q := Quiver(5, [[1,1,"delta"], [1,2,"alpha"], [2,3,"beta_1"], [3, 4, "beta_2"],[5,2,"gamma"]]);
    KQ := PathAlgebra(Rationals,Q);;
    AssignGeneratorVariables(KQ);
    return KQ/[alpha*beta_1, beta_1*beta_2, gamma*beta_1, delta*alpha, delta*delta];
    end;

A_prime := function()
    local Q_prime, KQ_prime;
    Q_prime := Quiver(4, [[1,1,"ell"],[1,2,"alpha"],[3,2,"beta"],[2,4,"gamma"],[2,4,"delta"]]);;
    KQ_prime := PathAlgebra(Rationals,Q_prime);;
    AssignGeneratorVariables(KQ_prime);
    return KQ_prime/[ell*ell, ell*alpha, alpha*gamma, alpha*delta, beta*delta];
    end;

# A := A_prime();
# AtA := TensorProductOfAlgebras(A, A)
# ModuleDeloopingLevelNotMoreThanN(SimpleModules(AtA)[11], 3);  
# AlgebraDeloopingLevelNotMoreThanN(AtA, 2); 
# One can see that the Algebra AtA has delooping level 3 by running the following code.