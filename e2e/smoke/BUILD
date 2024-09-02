"""Provides a simple way to test your rules as an external workspace.
Add a basic smoke-test target below.
"""

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@com_bookingcom_rules_flatbuffers//flatbuffers:defs.bzl", "flatbuffer_library_public")

# Replace with a usage of your rule/macro
filegroup(name = "empty")

build_test(
    name = "smoke_test",
    targets = [
        # targets you add above
        ":empty",
    ],
)

flatbuffer_library_public(
    name = "monster_fbs_java",
    srcs = ["monster.fbs"],
    outs = [
        "MyGame/Sample/Color.java",
        "MyGame/Sample/Equipment.java",
        "MyGame/Sample/EquipmentUnion.java",
        "MyGame/Sample/Monster.java",
        "MyGame/Sample/MonsterT.java",
        "MyGame/Sample/Vec3.java",
        "MyGame/Sample/Vec3T.java",
        "MyGame/Sample/Weapon.java",
        "MyGame/Sample/WeaponT.java",
    ],
    language_flag = "--java",
)

java_library(
    name = "monster_java",
    srcs = [":monster_fbs_java"],
)
