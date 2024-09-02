"Public API re-exports"

load("@com_github_google_flatbuffers//:build_defs.bzl", _flatbuffer_library_plubic = "flatbuffer_library_public")

def flatbuffer_library_plubic(**kwargs):
    kwargs.pop("flatc_path", None)
    _flatbuffer_library_plubic(flatc_path = "", **kwargs)
