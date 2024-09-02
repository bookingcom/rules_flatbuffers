<!-- Generated with Stardoc: http://skydoc.bazel.build -->


Rules for building flatbuffers with Bazel.


<a id="default_include_paths"></a>

## default_include_paths

<pre>
default_include_paths()
</pre>





<a id="flatbuffer_library_public"></a>

## flatbuffer_library_public

<pre>
flatbuffer_library_public(<a href="#flatbuffer_library_public-name">name</a>, <a href="#flatbuffer_library_public-srcs">srcs</a>, <a href="#flatbuffer_library_public-outs">outs</a>, <a href="#flatbuffer_library_public-language_flag">language_flag</a>, <a href="#flatbuffer_library_public-out_prefix">out_prefix</a>, <a href="#flatbuffer_library_public-includes">includes</a>, <a href="#flatbuffer_library_public-include_paths">include_paths</a>,
                          <a href="#flatbuffer_library_public-flatc_args">flatc_args</a>, <a href="#flatbuffer_library_public-reflection_name">reflection_name</a>, <a href="#flatbuffer_library_public-reflection_visibility">reflection_visibility</a>, <a href="#flatbuffer_library_public-compatible_with">compatible_with</a>,
                          <a href="#flatbuffer_library_public-restricted_to">restricted_to</a>, <a href="#flatbuffer_library_public-target_compatible_with">target_compatible_with</a>, <a href="#flatbuffer_library_public-output_to_bindir">output_to_bindir</a>, <a href="#flatbuffer_library_public-extra_env">extra_env</a>, <a href="#flatbuffer_library_public-kwargs">kwargs</a>)
</pre>

Generates code files for reading/writing the given flatbuffers in the requested language using the public compiler.

This rule creates a filegroup(name) with all generated source files, and
optionally a Fileset([reflection_name]) with all generated reflection
binaries.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="flatbuffer_library_public-name"></a>name |  Rule name.   |  none |
| <a id="flatbuffer_library_public-srcs"></a>srcs |  Source .fbs files. Sent in order to the compiler.   |  <code>[]</code> |
| <a id="flatbuffer_library_public-outs"></a>outs |  Output files from flatc.   |  <code>[]</code> |
| <a id="flatbuffer_library_public-language_flag"></a>language_flag |  Target language flag. One of [-c, -j, -js].   |  <code>None</code> |
| <a id="flatbuffer_library_public-out_prefix"></a>out_prefix |  Prepend this path to the front of all generated files except on single source targets. Usually is a directory name.   |  <code>""</code> |
| <a id="flatbuffer_library_public-includes"></a>includes |  Optional, list of filegroups of schemas that the srcs depend on.   |  <code>[]</code> |
| <a id="flatbuffer_library_public-include_paths"></a>include_paths |  Optional, list of paths the includes files can be found in.   |  <code>None</code> |
| <a id="flatbuffer_library_public-flatc_args"></a>flatc_args |  Optional, list of additional arguments to pass to flatc.   |  <code>["--gen-object-api", "--gen-compare", "--no-includes", "--gen-mutable", "--reflect-names", "--cpp-ptr-type flatbuffers::unique_ptr"]</code> |
| <a id="flatbuffer_library_public-reflection_name"></a>reflection_name |  Optional, if set this will generate the flatbuffer reflection binaries for the schemas.   |  <code>""</code> |
| <a id="flatbuffer_library_public-reflection_visibility"></a>reflection_visibility |  The visibility of the generated reflection Fileset.   |  <code>None</code> |
| <a id="flatbuffer_library_public-compatible_with"></a>compatible_with |  Optional, The list of environments this rule can be built for, in addition to default-supported environments.   |  <code>None</code> |
| <a id="flatbuffer_library_public-restricted_to"></a>restricted_to |  Optional, The list of environments this rule can be built for, instead of default-supported environments.   |  <code>None</code> |
| <a id="flatbuffer_library_public-target_compatible_with"></a>target_compatible_with |  Optional, The list of target platform constraints to use.   |  <code>None</code> |
| <a id="flatbuffer_library_public-output_to_bindir"></a>output_to_bindir |  Passed to genrule for output to bin directory.   |  <code>False</code> |
| <a id="flatbuffer_library_public-extra_env"></a>extra_env |  Optional, must be a string of "VAR1=VAL1 VAR2=VAL2". These get set as environment variables that "flatc_path" sees.   |  <code>None</code> |
| <a id="flatbuffer_library_public-kwargs"></a>kwargs |  Passed to the underlying genrule.   |  none |


