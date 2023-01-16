
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :red if (/Errors \((\d+) failures, (\d+) tests/.match(output))
  return :red if output.include?('(core dumped)')
  return :green if /OK \((\d+) tests, (\d+) ran/.match(output)
  return :amber
}
