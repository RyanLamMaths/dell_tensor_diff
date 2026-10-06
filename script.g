ModuleDeloopingLevelLessThanN := function (M, n)
# Given A-moduule M and positive integer n, output whether dell(M) <= n.
# Note: the result of CommonDirectSummand can be false or a list.
# In the case of outputting anything other than false, should be counted as true.
local N, nM;
nM := NthSyzygy(M, n);
Print("Nth Syzygy is", nM, "\n");
if Dimension(nM) = 0 or IsProjectiveModule(nM) then
    Print("Results: True", "\n");
    return 0;
else
    N := NthSyzygy(TransposeOfModule(NthSyzygy(TransposeOfModule(nM), n+1)), n+1);
    Print("Testing summand:", N, "\n");
    Print("Results:", CommonDirectSummand(nM, N), "\n");
    return 0;
fi;
end;

AlgebraDeloopingLevelLessThanN := function(A, n)
local i, M;
i := 1;
for M in SimpleModules(A) do 
    Print("Start Test for Simple number ", i, "\n");
    ModuleDeloopingLevelLessThanN(M, n);
    i := i + 1;
od;
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
# ModuleDeloopingLevelLessThanN(SimpleModules(AtA)[11], 3);  
# AlgebraDeloopingLevelLessThanN(AtA, 2); 
# One can see that the Algebra AtA has delooping level 3 by running the following code.