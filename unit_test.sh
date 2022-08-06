#!/usr/bin/env bash

red=$(tput setaf 1)
green=$(tput setaf 2)
none=$(tput sgr0)

show_help() {
    printf "usage: $0 [--help] [--report] [--test] [<path to package>]
Script for running all unit and widget tests with code coverage.
(run from root of repo)
where:
    <path to package>
        runs all tests with coverage and reports
    -t, --test
        runs all tests with coverage, but no report
    -r, --report
        generate a coverage report
        (requires lcov, install with Homebrew)
    -h, --help
        print this message
"
}

run_tests() {
    if [[ -f "pubspec.yaml" ]]; then
        rm -f coverage/lcov.info
        rm -f coverage/lcov-final.info
        cd movie
        rm -f coverage/lcov.info
        rm -f coverage/lcov-final.info
        flutter test --coverage
        lcov -r coverage/lcov.info lib/resources/l10n/\* lib/\*/fake_\*.dart \
             -o coverage/lcov-final.info
        genhtml -o coverage coverage/lcov-final.info
        open coverage/index-sort-l.html
        cd ..
        cd search
        rm -f coverage/lcov.info
        rm -f coverage/lcov-final.info
        flutter test --coverage
        lcov -r coverage/lcov.info lib/resources/l10n/\* lib/\*/fake_\*.dart \
             -o coverage/lcov-final.info
        genhtml -o coverage coverage/lcov-final.info
        open coverage/index-sort-l.html
        cd ..
        cd tv
        rm -f coverage/lcov.info
        rm -f coverage/lcov-final.info
        flutter test --coverage
        lcov -r coverage/lcov.info lib/resources/l10n/\* lib/\*/fake_\*.dart \
             -o coverage/lcov-final.info
        genhtml -o coverage coverage/lcov-final.info
        open coverage/index-sort-l.html
        cd ..
        printf "\nMovie Module: ${green}ALL TEST PASSED${none} - ✅"
        printf "\nSearch Module: ${green}ALL TEST PASSED${none} - ✅"
        printf "\nTV Module: ${green}ALL TEST PASSED${none} - ✅"
    else
        printf "\n${red}Error: this is not a Flutter project${none}"
        exit 1
    fi
}

case $1 in
    -h|--help)
        show_help
        ;;
    -t|--test)
        run_tests
        ;;    
    -r|--report)
        run_report
        ;;
    *)
        run_tests
        ;;
esac