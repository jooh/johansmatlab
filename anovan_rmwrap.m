% repeated-measures ANOVA with a full model. A convenience wrapper for the
% built-in ANOVAN, since coding up the RM case involves a bit of
% data mangling and lots of custom input flags. The resulting fits should
% be equivalent to what you get out of SPSS with standard settings.
% 
% INPUTS
% data      2D matrix with subjects in rows and conditions in columns. Any
%               rows with NaN entries are removed before fitting.
% facts     struct array with one entry per factor and the fields name
%               (char) and levs (where each entry corresponds to the level
%               assigned to that column of the data matrix).
%
% Outputs are as in anovan.
%
% varargout = anovan_rmwrap(data,facts)
function varargout = anovan_rmwrap(data,facts)

assert(ismatrix(data),'data must be 2d matrix');

% remove nan rows
valid = ~any(isnan(data),2);
data = data(valid,:);

% set up the vectorised factor level indicator variables
[nsub,ncon] = size(data);
factcell = arrayfun(@(thisfact)ascol(repmat(asrow(thisfact.levs),...
    [nsub 1])),facts,'uniformoutput',0);
% add the subject variable (random effect)
factcell{end+1} = ascol(repmat([1:nsub]',[1 ncon]));

% random here to make sure subject is a random effect, model full to get
% all interaction terms
[varargout{1:nargout}] = anovan(data(:),factcell,'display','off',...
    'random',numel(factcell),'model','full',...
    'varnames',[{facts(:).name} {'subject'}]);
