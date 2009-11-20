use inc::Module::Install;
name        'Math-Category';
all_from    'lib/Math/Category.pm';
readme_from 'lib/Math/Category.pm';

requires 'Moose';
requires 'Sub::Exporter';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';

auto_set_repository;
use_test_base;
auto_include;
WriteAll;
