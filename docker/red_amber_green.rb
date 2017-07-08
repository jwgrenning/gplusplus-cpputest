
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :red   if /Errors \((\d+) failures, (\d+) tests/.match(output)
  return :green if /OK \((\d+) tests, (\d+) ran/.match(output)
  return :amber
}
