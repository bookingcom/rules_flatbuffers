"""Prebuilts for flatc
"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64
TOOL_VERSIONS = {
    "24.3.25": {
        "x86_64-apple-darwin": "sha384-0/D3823CMev/Mty/Y+TAQkgSCUT1Kt1v8iygtLISJc9sn6Ki/qEJiqdTMqobyo/a",
        "aarch64-apple-darwin": "sha384-GS3MPvt6mli0lrxl1HYQmWrW63KRqdDF9L57mLmZ+ds4rQMY5YkIIon+5LYFw6VS",
        "x86_64-pc-windows-msvc": "sha384-zsWmwy5stIAUmWrz7QSfAy2i7GiclzIJxuVE3eNdCaaL21rqK271A1zN6GwtY6Ew",
        "x86_64-unknown-linux-gnu": "sha384-va2xskq6toJ1LX1/j4r5sLV7i9GTVHhlQyBxzX4TjZ+VFcMrP+FBWWYqivbtsRXU",
    },
}

PLATFORMS_MAPPING = {
    "x86_64-unknown-linux-gnu": "Linux.flatc.binary.clang++-15",
    "x86_64-apple-darwin": "MacIntel.flatc.binary",
    "aarch64-apple-darwin": "Mac.flatc.binary",
    "x86_64-pc-windows-msvc": "Windows.flatc.binary",
}
