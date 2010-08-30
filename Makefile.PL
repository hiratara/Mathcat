use inc::Module::Install;
name        'Math-Category';
all_from    'lib/Mathcat.pm';
readme_from 'lib/Mathcat.pm';

requires 'Any::Moose';
requires 'Sub::Exporter';
recommends 'Mouse';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';

auto_set_repository;
use_test_base;
auto_include;
WriteAll;
