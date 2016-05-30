% convenience wrapper for mkdir. Create a directory if the path does not
% already exist. Optionally remove existing directory (useful for ensuring
% that new output files are not mixed with old ones).
%
% 
% INPUT         DEFAULT DESCRIPTION
% d             -       path to directory
% rmexisting    false   delete existing directory before creating a new one
% confirmrm     true    confirm delete operation above (good idea!)
%
% [madedir,d] = mkdirifneeded(d,rmexisting=false,confirmrm=true)
function [madedir,d] = mkdirifneeded(d,rmexisting,confirmrm)

if exist(d,'dir')
  madedir = false;
  if exist('rmexisting','var') && rmexisting
      if ~exist('confirmrm','var') || confirmrm
          resp = input(sprintf('directory %s exists, delete? Y/N: ',d),'s');
          switch lower(resp)
              case 'y'
                  % ok then
              case 'n'
                  % leave the directory alone
                  return;
              otherwise
                  error('unknown response: %s',resp);
          end
      end
      % delete the directory (and create a new one below)
      success = rmdir(d,'s');
      assert(success,'rmdir failed for path %s',d);
  else
      % leave the directory alone
      return
  end
end

success = mkdir(d);
assert(success,'mkdir failed for path %s',d);
madedir = true;
