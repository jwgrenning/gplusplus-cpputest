
lambda { |stdout,stderr,status|
  output = stdout + stderr
  if (/Errors \((\d+) failures, (\d+) tests/.match(output)
      or output.include?('(core dumped)'))
    return :red
  end
  return :green if /OK \((\d+) tests, (\d+) ran/.match(output)
  return :amber
}
