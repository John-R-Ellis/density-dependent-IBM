function b=randPL(gamma,eps)

%  gamma is the PL exponent
%  eps is parameter of the PL distribution
                                         sq2=sqrt(2);
             gam2=1/(1-gamma);
a=randn;
                    erfmod=erf(a/sq2);
if a>0
    anew=eps*((1-erfmod)^gam2-1);  end;
if a<0
    anew=eps*(1-(1+erfmod)^gam2);  end;

%b=anew;
b=abs(anew);

%                end;
