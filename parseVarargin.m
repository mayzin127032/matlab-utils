% parseVarargin Get argument names and corresponding values when using
%   a variable number of input arguments (vargargin).
%
%   vmap = parseVarargin(args, validArgs, defaultValues)
%
%   INPUT:
%   args:      cell array with argument names and values (result of varargin)
%   validArgs: cell array with valid argument names
%
%   Example:
%   f = createCircle(varargin)
%       validArgs = {'radius','center'};
%       defaultValues = {10,[42,42]};
%       vmap = parseVarargin(varargin,validArgs,defaultValues);
%       ...   
%       ...   % The value used for radius will be vmap('radius') and the 
%       ...   % value used for center will be vmap('center').
%   end
%
%   Stavros Tsogkas, <stavros.tsogkas@ecp.fr>
%   Last update: January 2015


function vmap = parseVarargin(args, validArgs, defaultValues)

assert(iscell(validArgs) && iscell(defaultValues), ...
    'validArgs and defaultValues must be cell arrays');
vmap = containers.Map(validArgs,defaultValues);
if ~isempty(args)
    nArgs = length(args);
    assert(iscell(args), 'Argument list is not a cell array');
    assert(mod(nArgs,2) == 0, 'An even number of arguments is required (key/val pairs)')
    argNames = args(1:2:end);
    argVals  = args(2:2:end);
    for i=1:nArgs/2
        try 
            assert(any(strcmp(argNames{i}, validArgs)))
            vmap(argNames{i}) = argVals{i};
        catch
            celldisp(validArgs,'Valid argument ');
            error(['''' argNames{i} ''' is an invalid argument name.'])
        end
    end
end