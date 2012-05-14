% Simple, dumb function to mkdir only if there isn't already one. Also
% checks that mkdir was successful. Returns true if a directory was
% created, otherwise false.
% madedir = mkdirifneeded(d)
function madedir = mkdirifneeded(d)

if exist(d,'dir')
  madedir = false;
  return
end

success = mkdir(d);

if ~success
  error('mkdir failed!')
end
madedir = true;
