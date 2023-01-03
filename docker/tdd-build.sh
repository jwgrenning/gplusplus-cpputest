# source this file from cyber-dojo.sh
# You can adjust the build output and behavior with these symbols

#SHOW_TEST_NAMES="N" #Uncomment to announce each test

#GCOV="Y"           #Uncomment to check test coverage

#MONITORED_BUILD="N" #Comment out to turn off coverage and printf monitoring


#-------------------------------------------------
# You should not change below this line

CAPTURED_GCOV_RUN=gcov.out
MONITORED_BUILD_SPEC=monitored-build.txt
MONITORED_BUILD="${MONITORED_BUILD:-Y}"

if [ ! -e $MONITORED_BUILD_SPEC ]; then
    echo "Not monitoring coverage"
    MONITORED_BUILD="N"
fi 

if [ "${SHOW_TEST_NAMES}" = "Y" ]; then
    VERBOSE=vtest
fi

if [ "${SHOW_TEST_COVERAGE}" = "Y" ]; then
    GCOV="Y"
fi

trap tidy_up EXIT

function tidy_up()
{
  delete_files "*.out" "*_tests.txt" $CAPTURED_GCOV_RUN
  delete_dirs objs/ lib/ gcov/
}

function delete_dirs()
{
  for dirname in "$@"
  do
      rm -rf ${dirname} &> /dev/null || true
  done
}

function delete_files()
{
  for filename in "$@"
  do
      rm -f ${filename} &> /dev/null || true
  done
}

build()
{
    if [ "$GCOV" == "Y" ]; then
        export GCOV_ARGS+="-b -c"
        make_gcov
    elif [ "$MONITORED_BUILD" == "Y" ]; then
        MONITORED_FILE=$(cat $MONITORED_BUILD_SPEC)
        GCOV_FILE=gcov/$(basename $MONITORED_FILE).gcov
        extension="${MONITORED_FILE##*.}"
        if [ $extension == "c" ]; then
            export GCOV_ARGS+="-b -c"
        fi
        monitored_build
    else
        make $VERBOSE
    fi
}

make_gcov()
{
    make CPPUTEST_USE_GCOV=Y gcov
    status=$?
    cat $GCOV_FILE
}

monitored_build()
{
    make CPPUTEST_USE_GCOV=Y gcov $VERBOSE >$CAPTURED_GCOV_RUN
    makeup_for_gcov_not_returing_status
    status=$?
    if [ "$?" == "0" ]; then
        get_rid_of_gcov_noise
        print_untested_code
        print_lines_with_printf
    fi
    return $status
}

mark_test_run_yellow()
{
    sed -i '' -e's/^OK /OK, But so what! /' test.out
}

dashed_line()
{
    echo "--------------------------------------------------------------"
}

get_rid_of_gcov_noise()
{
    egrep -v "No branches|filterGcov|^[ 1][ 0-9][0-9]?\.[0-9][0-9]%|See gcov directory|Creating .*\.gcov"  $CAPTURED_GCOV_RUN
}

find_printfs()
{
    grep -n "^ *printf(.*);" ${MONITORED_FILE}
}

untested_code_lines()
{
    if [ -e "${GCOV_FILE}" ]; then
        grep "#####: \|taken 0" $GCOV_FILE
    fi
}

untested_code_snip()
{
    dashed_line
    grep -B6 -A6 "#####: \|taken 0" $GCOV_FILE |\
      sed -e's/#####:.*$/& <<<<---- LINE NEVER EXECUTED ----<<<</' \
          -e's/branch.*taken 0/& <<<<---- BRANCH NEVER TAKEN IN PREVIOUS CONDITIONAL ----<<<</'
    dashed_line
}

makeup_for_gcov_not_returing_status()
{
    if [ "$(grep -c 'OK '  $CAPTURED_GCOV_RUN)" = "1" ]; then
        return 0
    else
        return 3
    fi
}

print_untested_code()
{
    if [[ "$(untested_code_lines)" != "" ]]; then
        print_untested_code_message
        mark_test_run_yellow
        status=$((status+42))
    fi
}

foo()
{
    [[ "$(untested_code_snip)" != "" ]] && lines="Y" || lines="N"#

    if [ ${status} -eq 0 ]; then
        if [ "${lines}" == "Y" ] || [ "${branches}" == "Y" ]; then
            print_untested_code_message $lines $branches
            mark_test_run_yellow
            status=$((status+42))
        fi
    fi
}

print_untested_code_message()
{
    echo
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!                                                        !!"
    echo "!!          YOUR CODE GOT AHEAD OF YOUR TESTS!            !!"
    echo "!!                                                        !!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    print_way_out
    untested_code_snip
}

print_way_out()
{
    cat <<EOF
    
You get this message when you write code that is not yet needed by
your current test cases.

The coverage report below may show

 * "LINE NEVER EXECUTED" 
 * "BRANCH NEVER TAKEN IN PREVIOUS CONDITIONAL"

Delete (or comment out) the code that is not yet needed.

Try to avoid getting this message by doing TDD!
  Work in small steps
  Write a test
  Watch it fail (maybe due to build errors)
  Make it pass with the simplest implementation
  Continue

EOF

}

print_untested_lines_message()
{
    if [ "$1" == "Y" ]; then
        untested_code
    fi
}

print_lines_with_printf()
{
    printfs=$(find_printfs)
    if [ "${printfs}" != "" ]; then
        print_found_printf_message "${printfs}"
        dashed_line
        mark_test_run_yellow
        status=$((status+100))
    fi
}

print_found_printf_message()
{
    cat <<EOF

printf found on these lines:

$1

Do you really need printf now? Are you debugging?

Not that you'll never need printf to find a bug, but I'd like you to
work in small steps where you usually only have one thing wrong at a
time.

I suspect you wrote too much code. TDD uses small deliberate steps
to help avoid debugging.

Now, I suggest you revert you code to the last time it worked and
try again.  You probably won't make the same mistake.

To revert your code to any prior test run, click a previous traffic signal
(a green one preferably), then choose revert.  At any rate, you'll need to
get rid of printf to get back to green.

EOF

}

core_dumped_fault_help()
{
    cat error.out <<EOF

Running tests again with verbose enabled."
The last test started may lead you to the error."

EOF
    make vtest
    echo
}

get_rid_of_make_noise()
{
    egrep -v 'rm -f|@: not found|tput: not found'
}

output_for_test_run()
{
    if [ "$(grep 'core dumped' error.out | wc -l)" != "0" ]; then
        core_dumped_fault_help >seg.out 2>seg-error.out
        cat seg.out seg-error.out
    else
        cat test.out error.out | get_rid_of_make_noise
    fi
}

build >test.out 2>error.out
status=$?
output_for_test_run


exit $status
