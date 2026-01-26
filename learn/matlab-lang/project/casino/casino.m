disp('% Set the gambler''s prior'),
 
table = ([18/37,0.95,0.0; 0.6,0.05,0.0; 0.0,0.0,0.0]), %SET VALUES
              
disp('% Check that total prior probability sums to one'),

prior_sum = table(1,2) + table(2,2),

if prior_sum ~= 1,
    disp('% oops! sum of prior probabilities does not equal one')
end

disp(' '), 
disp('% plot the prior probability mass function'),
 
bar(table(1:2,1),table(1:2,2:3),1),
axis([0,1,0,1]),
xlabel('probability that the ball lands in a red space (P(Red))'),
ylabel('probability'),
legend('prior probability'),
 

disp('% Set data observation'),
 
num_red = 10, %SET VALUE
num_spins = 14, %SET VALUE


disp('% Calculate posterior probabilities using Bayes'' Rule'),

binomial_coeff = factorial(num_spins)/(factorial(num_red)*factorial(num_spins - num_red)),

table(1,3) = (binomial_coeff * (table(1,1)^num_red*(1-table(1,1))^(num_spins-num_red)) * table(1,2)) / ((binomial_coeff * (table(1,1)^num_red*(1-table(1,1))^(num_spins-num_red)) * table(1,2)) + (binomial_coeff * (table(2,1)^num_red*(1-table(2,1))^(num_spins-num_red)) * table(2,2)) );
table(2,3) = (binomial_coeff * (table(2,1)^num_red*(1-table(2,1))^(num_spins-num_red)) * table(2,2)) / ((binomial_coeff * (table(1,1)^num_red*(1-table(1,1))^(num_spins-num_red)) * table(1,2)) + (binomial_coeff * (table(2,1)^num_red*(1-table(2,1))^(num_spins-num_red)) * table(2,2)) ),

disp(' '), 
disp('% add the posterior probability mass function to the plot'),
 
bar(table(1:2,1),table(1:2,2:3),1),
axis([0,1,0,1]),
xlabel('probability that the ball lands in a red space (P(Red))'),
ylabel('probability'),
legend('prior probability','posterior probability'),
 

disp('% Calculate E(P(Red)) based on posterior probabilities'),
 
table(3,3) = table(1,1)*table(1,3) + table(2,1)*table(2,3),

disp('% Is the expected return on the Red bet > 0?'),
disp('(This requires that E(P(Red)) > 0.5)'),

if table(3,3) > 0.5,
    disp('% Yes, the Bayesian gambler should bet')
        elseif table(3,3) <= 0.5,
    disp('% No, the Bayesian gambler should not bet')
end