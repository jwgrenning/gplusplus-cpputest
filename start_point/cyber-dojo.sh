
trap tidy_up EXIT
function tidy_up()
{
  # cyber-dojo returns text files under /sandbox that are
  # created/deleted/changed. In here you can remove any
  # such files you don't want returned to the browser.
  [ ! -d objs/ ] || rm -rf objs/
}

export CPPUTEST_HOME=/cpputest
make
