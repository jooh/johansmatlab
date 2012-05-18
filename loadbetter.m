% Convenience function for loading the variables stored in a mat file directly
% to output arguments. Better than calling load without output because you know
% what gets loaded, and better than calling with output because you don't have
% to map the output struct's fields to variables. NB variables are returned in
% alphabetical order.
% varargout = loadbetter(matfile);
function varargout = loadbetter(matfile);

m = load(matfile);
fn = sort(fieldnames(m));
nm = length(fn);
assert(nm == nargout,sprintf('asked for %d outputs but %s contains %d variables',...
    nargout,matfile,nm));

for f = 1:nm
    varargout(f) = {m.(fn{f})};
end
