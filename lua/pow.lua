local a = 0
function pow(x, y)
  local p = 1
  for _ = 1, y do
    a = a + 1
    p = p * x
  end
  return p
end

local b = 0
function fast_pow(x, y)
  b = b + 1
  if y < 1 then return 1 end
  if y < 2 then return x end
  local m = fast_pow(x, y // 2)
  if y % 2 == 1 then
    return m * m * x
  end
  return m * m
end

print('pow(2, 32) = ' .. pow(2, 32) .. ' (ran ' .. a .. ' times)')

print('fast_pow(2, 32) = ' .. fast_pow(2, 32) .. ' (ran ' .. b .. ' times)')
