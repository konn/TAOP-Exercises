% pension(Person, Pension) :- Pension は Person が受け取る年金の種類だぴょん.
pension(X, invalid_pension) :- invalid(X).
pension(X, old_age_pension) :- over_65(X), paid_up(X).
pension(X, supplementary_benefit) :- over_65(X).
invalid(mc_tavish).
over_65(mc_tavish). over_65(mc_donald). over_65(mc_duff).
paid_up(mc_tavish). paid_up(mc_donald).

entitlement(X, Y) :- pension(X, Y).
entitlement(X, nothing) :- not( pension(X, Y) ).