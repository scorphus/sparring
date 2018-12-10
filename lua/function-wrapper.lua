local function fib(n)
  if n < 1 then return 0 end
  if n < 3 then return 1 end
  return fib(n - 2) + fib(n - 1)
end

local function cached(f)
  local _cache_ = {}
  function wrapper(n)
    local r = _cache_[n]
    if not r then
      r = f(n)
      _cache_[n] = r
    end
    return r
  end
  return wrapper
end

print('With no cache...')
for n = 30, 33 do
  print('  ' .. n .. ': ' .. fib(n))
end

print('With cache...')
fib = cached(fib)

for n = 30, 40 do
  print('  ' .. n .. ': ' .. fib(n))
end
