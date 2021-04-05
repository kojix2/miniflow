# Miniflow

![test](https://github.com/kojix2/miniflow/workflows/test/badge.svg)
[![Gem Version](https://badge.fury.io/rb/miniflow.svg)](https://badge.fury.io/rb/miniflow)
[![Docs Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://rubydoc.info/gems/miniflow)

A very small tool to help you execute workflows


API overview

```md
* FileCheck module
  - check_file(path, extnames)
  - check_file_exist(path)
  - check_file_extname(path, extnames)
  - mkdir_p(*args)

* Flow class
  - run
  - before_run
  - main_run
  - after_run
  - dir
  - odir
  - show_start
  - show_results
  - show_exit_error
  - check_output_files
  - cmd

* Tool class
  - method_missing
  - []
  - available?
  - cmd

* TTYCommand # custom pretty print
  - run2
  - include_meta_character?
```
