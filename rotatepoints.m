% Rotate 2D points p by angle phi (radians). xy should be in rows, multiple
% coordinates can be entered in columns. phi can be positive for clockwise
% and negative for counterclockwise rotations.
% p = rotatepoints(p,phi);
function ptrans = rotatepoints(p,phi)

% ensure input is a 2 by npoints matrix
assert(size(p,1)==2,'points must be 2D (two rows)');
assert(ndims(p)==2,'input p matrix must be 2D (xy by npoints)');
% support for counterclockwise rotation
if phi<0
    phi = (2*pi) + phi;
end
% ensure you aren't trying to rotate beyond a full revolution
assert(phi<=(2*pi),'phi must be be in range 0 to 2*pi')

rotmat = [cos(phi) -sin(phi); sin(phi) cos(phi)];
ptrans = rotmat * p;
