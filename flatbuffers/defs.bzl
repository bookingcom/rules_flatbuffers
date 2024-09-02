# Description:
#   BUILD rules for generating flatbuffer files in various languages.
#
# Based on https://github.com/google/flatbuffers/blob/204473cdb58a354506040826b47ef9329dc5c79c/build_defs.bzl

"""
Rules for building flatbuffers with Bazel.
"""

def default_include_paths():
    return [
        "./",
        "$(GENDIR)",
        "$(BINDIR)",
    ]

DEFAULT_FLATC_ARGS = [
    "--gen-object-api",
    "--gen-compare",
    "--no-includes",
    "--gen-mutable",
    "--reflect-names",
    "--cpp-ptr-type flatbuffers::unique_ptr",
]

def flatbuffer_library_public(
        name,
        srcs = [],
        outs = [],
        language_flag = None,
        out_prefix = "",
        includes = [],
        include_paths = None,
        flatc_args = DEFAULT_FLATC_ARGS,
        reflection_name = "",
        reflection_visibility = None,
        compatible_with = None,
        restricted_to = None,
        target_compatible_with = None,
        output_to_bindir = False,
        extra_env = None,
        **kwargs):
    """Generates code files for reading/writing the given flatbuffers in the requested language using the public compiler.

    This rule creates a filegroup(name) with all generated source files, and
    optionally a Fileset([reflection_name]) with all generated reflection
    binaries.

    Args:
      name: Rule name.
      srcs: Source .fbs files. Sent in order to the compiler.
      outs: Output files from flatc.
      language_flag: Target language flag. One of [-c, -j, -js].
      out_prefix: Prepend this path to the front of all generated files except on
          single source targets. Usually is a directory name.
      includes: Optional, list of filegroups of schemas that the srcs depend on.
      include_paths: Optional, list of paths the includes files can be found in.
      flatc_args: Optional, list of additional arguments to pass to flatc.
      reflection_name: Optional, if set this will generate the flatbuffer
        reflection binaries for the schemas.
      reflection_visibility: The visibility of the generated reflection Fileset.
      output_to_bindir: Passed to genrule for output to bin directory.
      compatible_with: Optional, The list of environments this rule can be
        built for, in addition to default-supported environments.
      restricted_to: Optional, The list of environments this rule can be built
        for, instead of default-supported environments.
      target_compatible_with: Optional, The list of target platform constraints
        to use.
      output_to_bindir: Passed to genrule for output to bin directory.
      extra_env: Optional, must be a string of "VAR1=VAL1 VAR2=VAL2". These get
        set as environment variables that "flatc_path" sees.
      **kwargs: Passed to the underlying genrule.
    """

    if language_flag == None:
        fail("language_flag must be set")

    reflection_include_paths = include_paths
    if include_paths == None:
        include_paths = default_include_paths()
    include_paths_cmd = ["-I %s" % (s) for s in include_paths]

    extra_env = extra_env or ""

    # '$(@D)' when given a single source target will give the appropriate
    # directory. Appending 'out_prefix' is only necessary when given a build
    # target with multiple sources.
    output_directory = (
        ("-o $(@D)/%s" % (out_prefix)) if len(srcs) > 1 else ("-o $(@D)")
    )

    genrule_cmd = " ".join([
        "set -eou pipefail;",
        "SRCS=($(SRCS));",
        "for f in $${SRCS[@]:0:%s}; do" % len(srcs),
        "OUTPUT_FILE=\"$(OUTS)\" %s $(location @com_bookingcom_rules_flatbuffers//flatbuffers:resolved_toolchain)" % (extra_env),
        " ".join(include_paths_cmd),
        " ".join(flatc_args),
        language_flag,
        output_directory,
        "$$f;",
        "done;",
    ])

    genrule_cmd += "; ".join([
        "pushd $(@D)",
        "find . -type f | sort | sed 's!\\./!!g' > $$TMPDIR/generated",
        "echo $(OUTS) | tr \" \" \"\n\" | sed \"s!$(@D)/!!g\"| sort > $$TMPDIR/expected",
        "diff -u $$TMPDIR/expected $$TMPDIR/generated",
    ])

    native.genrule(
        name = name,
        srcs = srcs + includes,
        outs = outs,
        output_to_bindir = output_to_bindir,
        tools = ["@com_bookingcom_rules_flatbuffers//flatbuffers:resolved_toolchain"],
        cmd = genrule_cmd,
        compatible_with = compatible_with,
        target_compatible_with = target_compatible_with,
        restricted_to = restricted_to,
        message = "Generating flatbuffer files for %s:" % (name),
        **kwargs
    )
    if reflection_name:
        if reflection_include_paths == None:
            reflection_include_paths = default_include_paths()
        reflection_include_paths_cmd = ["-I %s" % (s) for s in reflection_include_paths]
        reflection_genrule_cmd = " ".join([
            "set -eou pipefail;",
            "SRCS=($(SRCS));",
            "for f in $${SRCS[@]:0:%s}; do" % len(srcs),
            "$(location @com_bookingcom_rules_flatbuffers//flatbuffers:resolved_toolchain)",
            "-b --schema",
            " ".join(flatc_args),
            " ".join(reflection_include_paths_cmd),
            language_flag,
            output_directory,
            "$$f;",
            "done",
        ])
        reflection_outs = [
            (out_prefix + "%s.bfbs") % (s.replace(".fbs", "").split("/")[-1])
            for s in srcs
        ]
        native.genrule(
            name = "%s_srcs" % reflection_name,
            srcs = srcs + includes,
            outs = reflection_outs,
            output_to_bindir = output_to_bindir,
            compatible_with = compatible_with,
            restricted_to = restricted_to,
            target_compatible_with = target_compatible_with,
            cmd = reflection_genrule_cmd,
            message = "Generating flatbuffer reflection binary for %s:" % (name),
            visibility = reflection_visibility,
            tools = ["@com_bookingcom_rules_flatbuffers//flatbuffers:resolved_toolchain"],
        )
        native.filegroup(
            name = "%s_out" % reflection_name,
            srcs = reflection_outs,
            visibility = reflection_visibility,
            compatible_with = compatible_with,
            restricted_to = restricted_to,
        )
