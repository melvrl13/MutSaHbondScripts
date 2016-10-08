% Script for creating hydrogen bond decision tree. You will need to change
% inputs throughout. Places that require such changes are noted in
% comments.

% Insert the path to the hydrogen bond trajectory file between the single
% quotes.
HBondTraj=importdata('hbond_trajectory.csv', ',', 1);


traj = HBondTraj.data;
labels(1:5000,1) = {'carbo'};
labels(5001:10000,1) = {'cis'};
labels(10001:15000,1) = {'fdu'};
labels = categorical(labels);
full_tree = fitctree(traj, labels);
view(full_tree, 'Mode', 'Graph')
num_branches = max(full_tree.PruneList);
err = zeros(num_branches,1);
for n=1:num_branches
tprune = prune(full_tree, 'level', n);
err(n) = loss(tprune,traj,labels);
end
plot(1:num_branches,err)
xlabel('Prune level')
ylabel('Fraction wrong')
title('Pruning decision tree')