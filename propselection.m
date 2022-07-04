function [i] = propselection(value,fitness,pop_size)
avg_fitness = fitness/pop_size;
i = round(value/avg_fitness);
end