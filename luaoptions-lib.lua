-- luacheck: ignore ly log self luatexbase internalversion font fonts tex token kpse status
local err, warn, info, log = luatexbase.provides_module({
    name               = "luaoptions-lib",
    version            = '0.8',  --LUAOPTIONS_VERSION
    date               = "2022/10/30",  --LUAOPTIONS_DATE
    description        = "Module luaoptions-lib.",
    author             = "The lualatex-tools Project",
    copyright          = "2015-2022 - the lualatex-tools Project",
    license            = "MIT",
})

local lib = {}
lib.TEX_UNITS = {'bp', 'cc', 'cm', 'dd', 'in', 'mm', 'pc', 'pt', 'sp', 'em',
'ex'}

-------------------------
-- General tool functions

function lib.basename(str)
--[[
  Given the full path to a file, return only the file name (without path).
  If there is no slash, return the full name.
--]]
    return str:gsub(".*/(.*)", "%1") or str
end


function lib.contains(table_var, value)
--[[
  Returns the key if the given table contains the given value, or nil.
  A value of 'false' (string) is considered equal to false (Boolean).
--]]
    for k, v in pairs(table_var) do
        if v == value then return k
        elseif v == 'false' and value == false then return k
        end
    end
end


function lib.contains_key(table_var, key)
-- Returs true if the given key is present in the table, nil otherwise.
    for k in pairs(table_var) do
        if k == key then return true end
    end
end


function lib.convert_unit(value)
--[[
  Convert a LaTeX unit, if possible.
  TODO: Understand what this *really* does, what is accepted and returned.
--]]
    if not value then return 0
    elseif value == '' then return false
    elseif value:match('\\') then
        local n, u = value:match('^%d*%.?%d*'), value:match('%a+')
        if n == '' then n = 1 end
        return tonumber(n) * tex.dimen[u] / tex.sp("1pt")
    else return ('%f'):format(tonumber(value) or tex.sp(value) / tex.sp("1pt"))
    end
end


function lib.current_font_size()
--[[
    Convenience function to return the font size of the current font
--]]
    return lib.fontinfo(font.current()).size
end


function lib.dirname(str)
--[[
  Given the full path to a file, return only the path (without file name),
  including the last slash. If there is no slash, return an empty string.
--]]
    return str:gsub("(.*/).*", "%1") or ''
end


local fontdata = fonts.hashes.identifiers
function lib.fontinfo(id)
--[[
  Return a LuaTeX font object based on the given ID
--]]
    return fontdata[id] or font.getfont(id)
end


function lib.max(a, b)
    a, b = tonumber(a), tonumber(b)
    if a > b then return a else return b end
end


function lib.min(a, b)
    a, b = tonumber(a), tonumber(b)
    if a < b then return a else return b end
end


function lib.mkdirs(str)
    local path
    if str:sub(1, 1) == '/' then path = '' else path = '.' end
    for dir in str:gmatch('([^%/]+)') do
        path = path .. '/' .. dir
        lfs.mkdir(path)
    end
end


function lib.orderedkeys(t)
    local orderedIndex = {}
    for k in pairs(t) do table.insert(orderedIndex, k) end
    table.sort(orderedIndex)
    return orderedIndex
end


function lib.orderedpairs(t)
    local key
    local i = 0
    local orderedIndex = lib.orderedkeys(t)
    return function ()
            i = i + 1
            key = orderedIndex[i]
            if key then return key, t[key] end
        end
end


function lib.print_table(t, indent)
-- Recursively print a table, avoiding recursion loops
    indent = indent or '  '
    local visited = {}
    local skips = 0

    local function _print_table(_t, _ind)
        local keys = lib.orderedkeys(_t)
        local display_keys = {}
        local length = 0
        for key, _ in pairs(_t) do
            length = lib.max(length, #tostring(key))
        end
        for key, _ in pairs(_t) do
            display_key = tostring(key)
            display_keys[key] = display_key .. string.rep(
                ' ', length - #display_key)
        end
        for k, v in lib.orderedpairs(_t) do
            if type(v) == 'table' then
                if visited[v] then
                    skips = skips + 1
                else
                    visited[v] = true
                    print(_ind..display_keys[k], v)
                    if #_ind > 40 then err("k") end
                    _print_table(v, _ind..indent)
                end
            else
                if v == '' then v = '(empty string)' end
                print(_ind..display_keys[k], v)
            end
        end
    end

    print()
    visited[t] = true
    print("Print table:", t)
    _print_table(t, indent)
    print()
    if skips > 0 then
        print(string.format('%s recursive tables skipped', skips))
    end
    print("============")
    print()
end

function lib.readlinematching(s, f)
    if f then
        local result = ''
        while result and not result:find(s) do result = f:read() end
        f:close()
        return result
    end
end


function lib.splitext(str, ext)
--[[
    If 'ext' is supplied return str stripped of the given extension,
    otherwise return the base and extension (if any)
--]]
    return ext and (str:match('(.*)%.'..ext..'$') or str)
        or (str:match('(.*)%.(%w*)$') or str)
end


------------------------------------
-- Engine, version, TeX distribution

local function _loaded(ext)
--[[
    Returns a function that checks whether a class or a package is loaded
    https://tex.stackexchange.com/questions/501635/
--]]
    local fmt = "ver@%s." .. ext
    return function(name)
        local macro = token.get_macro(fmt:format(name))
        return macro ~= nil
    end
end

-- Lua implementations of \@ifpackageloaded and \@ifclassloaded
lib.class_loaded = _loaded('cls')
lib.package_loaded = _loaded('sty')

local tex_engine = {}
setmetatable(tex_engine, tex_engine)

function tex_engine:__call()
--[[
    Defines the properties extracted from the first line of jobname.log.
--]]
    local f = io.open(tex.jobname..'.log')
    if not f then return end
    self.engine, self.engine_version, self.dist, self.dist_version, self.format, self.format_version =
        f:read():match(
            'This is ([^,]*), Version ([^%(]*) %(([^%)]*) ([^%)]*)%)%s+%(format=([^%)]*) ([^)]*)%)'
        )
    f:close()
    return self
end

function tex_engine:__index(k) return rawget(self(), k) end


lib.tex_engine = tex_engine
return lib
