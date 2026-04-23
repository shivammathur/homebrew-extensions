# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT85 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/8a39efa3cf3b275e402ddf3c4f6b611a5f69a499.tar.gz"
  version "2.1.2"
  sha256 "0a03e4b4ccb5755aaa0c9d65afb5906827395826641f2bad1c19291fce65ed2f"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_tahoe:   "294153ce2df5f221cc7adb0640f9b4516a9d2891921541ce3930bef7daa59ec6"
    sha256 arm64_sequoia: "1ffb7d3b0e6ff8ccdbd7f6b708efd700bf3a6a6b840f7ee89c260b83947f3b65"
    sha256 arm64_sonoma:  "24ec10637c6879d7a1ba32fbd43c7f393b8c7c06f5a1d6ff84aa65c6b603035c"
    sha256 sonoma:        "06bcb6fb17cd4a0174d6e405c3aa424192e85692316b31088bf058870808cc75"
    sha256 arm64_linux:   "96c9f7dd0be5210f4364bf1081de9c811fc8981d0cbaa632956d7d31f79a597d"
    sha256 x86_64_linux:  "03218941206c4ce212db4eab059499b164affc736d166ed06dc132a5900ca892"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    inreplace "config.m4", "c++17", "c++20"
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    inreplace "v8js_array_access.cc", "info.This()", "info.HolderV2()"
    inreplace "v8js_array_access.cc", "arr->GetPrototype()", "arr->GetPrototypeV2()"
    inreplace "v8js_object_export.cc",
              "self = info.This();\n\tv8::Local<v8::Array> result",
              "self = info.HolderV2();\n\tv8::Local<v8::Array> result"
    %w[GETTER SETTER QUERY DELETER].each do |prop|
      inreplace "v8js_object_export.cc",
                "info.This(), property, V8JS_PROP_#{prop}",
                "info.HolderV2(), property, V8JS_PROP_#{prop}"
    end
    inreplace "v8js_object_export.cc",
              "v8::GenericNamedPropertyEnumeratorCallback",
              "v8::NamedPropertyEnumeratorCallback"
    %w[
      v8js_array_access.cc
      v8js_convert.cc
      v8js_exceptions.cc
      v8js_object_export.cc
      v8js_v8.cc
    ].each do |file|
      inreplace file,
                "GetAlignedPointerFromInternalField(1)",
                "GetAlignedPointerFromInternalField(" \
                "1, v8::kEmbedderDataTypeTagDefault)"
    end
    inreplace "v8js_object_export.cc",
              "GetAlignedPointerFromInternalField(0)",
              "GetAlignedPointerFromInternalField(" \
              "0, v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_class.cc",
              "SetAlignedPointerInInternalField(1, Z_OBJ_P(getThis()))",
              "SetAlignedPointerInInternalField(" \
              "1, Z_OBJ_P(getThis()), v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_object_export.cc",
              "SetAlignedPointerInInternalField(0, ext_tmpl->Value())",
              "SetAlignedPointerInInternalField(" \
              "0, ext_tmpl->Value(), v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_object_export.cc",
              "SetAlignedPointerInInternalField(1, object)",
              "SetAlignedPointerInInternalField(" \
              "1, object, v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_object_export.cc",
              "SetAlignedPointerInInternalField(1, Z_OBJ(value))",
              "SetAlignedPointerInInternalField(" \
              "1, Z_OBJ(value), v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_v8object_class.cc",
              "str->Write(isolate, &c, 0, 1)",
              "str->WriteV2(isolate, 0, 1, &c)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
