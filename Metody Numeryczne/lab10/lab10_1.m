clear all; close all;

set(groot,'DefaultFigureColormap',hsv(64))

fun = @(x)( 100*(x(2) - x(1)^2)^2 + (1 - x(1))^2 );  % funkcja
x0 = [ 1, 2 ];                                    % punkt startowy

% Inicjalizacja zmiennych do przechowywania wyników
method_names = {'fminsearch', 'fminunc (quasi-newton)', 'fminunc (steepest-descent)',...
    'fminunc (analytic gradient)', 'fminunc (analytic gradient & hessian)',...
    'lsqnonlin', 'lsqnonlin (with jacobian)'};
function_calls = zeros(1, length(method_names));
iterations = zeros(1, length(method_names));

% fminsearch() - SIMPLEX
options = optimset('OutputFcn',@bananaout,'Display','off');
[x,fval,eflag,output] = fminsearch(fun,x0,options);
function_calls(1) = output.funcCount;
iterations(1) = output.iterations;

% fminunc() - QUASI-NEWTON
options = optimoptions('fminunc','Display','off',...
    'OutputFcn',@bananaout,'Algorithm','quasi-newton');
[x,fval,eflag,output] = fminunc( fun, x0, options );
function_calls(2) = output.funcCount;
iterations(2) = output.iterations;

% fminunc() - STEEPEST-DESCENT
options = optimoptions(options,'HessUpdate','steepdesc',...
    'MaxFunctionEvaluations',600);
[x,fval,eflag,output] = fminunc(fun,x0,options);
function_calls(3) = output.funcCount;
iterations(3) = output.iterations;

% fminunc() - ANALYTIC GRADIENT
grad = @(x)[ -400*(x(2) - x(1)^2)*x(1) - 2*(1 - x(1)); ...
    200*(x(2) - x(1)^2)];
fungrad = @(x)deal(fun(x),grad(x));
options = resetoptions(options,{'HessUpdate','MaxFunctionEvaluations'});
options = optimoptions(options,'SpecifyObjectiveGradient',true,...
    'Algorithm','trust-region');
[x,fval,eflag,output] = fminunc(fungrad,x0,options);
function_calls(4) = output.funcCount;
iterations(4) = output.iterations;

% fminunc() - ANALYTIC GRADIENT & HESSIAN
hess = @(x)[ 1200*x(1)^2 - 400*x(2) + 2, -400*x(1);
    400*x(1),      200 ];
fungradhess = @(x)deal(fun(x),grad(x),hess(x));
options.HessianFcn = 'objective';
[x,fval,eflag,output] = fminunc(fungradhess,x0,options);
function_calls(5) = output.funcCount;
iterations(5) = output.iterations;

% lsqnonlin() - NON-LINEAR LEAST-SQUARES
options = optimoptions('lsqnonlin','Display','off','OutputFcn',@bananaout);
vfun = @(x)[ 10*(x(2) - x(1)^2), 1 - x(1)];
[x,resnorm,residual,eflag,output] = lsqnonlin(vfun,x0,[],[],options);
function_calls(6) = output.funcCount;
iterations(6) = output.iterations;

% lsqnonlin() - NON-LINEAR LEAST-SQUARES + JACOBIAN
jac = @(x)[-20*x(1), 10; ...
    -1, 0  ];
vfunjac = @(x)deal(vfun(x),jac(x));
options.SpecifyObjectiveGradient = true;
[x,resnorm,residual,eflag,output] = lsqnonlin(vfunjac,x0,[],[],options);
function_calls(7) = output.funcCount;
iterations(7) = output.iterations;

% Tworzenie tabeli
results_table = table(method_names', function_calls', iterations', ...
    'VariableNames', {'Method', 'FunctionCalls', 'Iterations'});

disp(results_table);

set(groot,'DefaultFigureColormap',parula(64))
