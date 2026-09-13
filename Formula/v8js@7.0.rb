# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT70 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/shivammathur/v8js"
  url "https://github.com/shivammathur/v8js/archive/1777ce3d774747075432672977ca4e034813575a.tar.gz"
  version "2.1.2"
  sha256 "1064d6ec32c5e8699928f541607f709e3bf1da959ec0cd8bedb62b4a87dca8b7"
  head "https://github.com/shivammathur/v8js.git", branch: "php7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 arm64_tahoe:   "62777394cb299458e70e97b99f65b68d584cc9c88aee0d54246a6f18030d5004"
    sha256 arm64_sequoia: "8a65129687d98d538aa09fa8d5f9e5ee3c7c2f4f2c08864e787860f4f2926e44"
    sha256 arm64_sonoma:  "597ee77077d9780c58694e7b89abc81400490f7cb977accd653d7e3202ce4bea"
    sha256 sonoma:        "d7359880c3711fc492d63ec97453601f50887513faee9f98de378f1f1e22f1c1"
    sha256 arm64_linux:   "33f73520ffbd84bc14e3f14172a3a19047104a0755e65f03cf494e358753c424"
    sha256 x86_64_linux:  "b3c671ba88ad709587532493523da078d899b2f097ce88f66f68bf1dc2f5d18e"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Utils::Path.formula_opt_prefix("v8")}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing"
    ENV.append "LDFLAGS", "-lstdc++"
    inreplace "config.m4", "$PHP_LIBDIR", "libexec"
    inreplace "config.m4", "c++17", "c++20"
    inreplace "v8js_object_export.cc", "v8::GenericNamedPropertyEnumeratorCallback",
              "v8::NamedPropertyEnumeratorCallback"
    inreplace %w[v8js_array_access.cc v8js_convert.cc v8js_exceptions.cc v8js_object_export.cc v8js_v8.cc],
              "GetAlignedPointerFromInternalField(1)",
              "GetAlignedPointerFromInternalField(1, v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_object_export.cc", "GetAlignedPointerFromInternalField(0)",
              "GetAlignedPointerFromInternalField(0, v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_class.cc", "SetAlignedPointerInInternalField(1, Z_OBJ_P(getThis()))",
              "SetAlignedPointerInInternalField(1, Z_OBJ_P(getThis()), v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_object_export.cc" do |s|
      s.gsub! "SetAlignedPointerInInternalField(0, ext_tmpl->Value())",
              "SetAlignedPointerInInternalField(0, ext_tmpl->Value(), v8::kEmbedderDataTypeTagDefault)"
      s.gsub! "SetAlignedPointerInInternalField(1, object)",
              "SetAlignedPointerInInternalField(1, object, v8::kEmbedderDataTypeTagDefault)"
      s.gsub! "SetAlignedPointerInInternalField(1, Z_OBJ(value))",
              "SetAlignedPointerInInternalField(1, Z_OBJ(value), v8::kEmbedderDataTypeTagDefault)"
    end
    inreplace "v8js_v8object_class.cc", "str->Write(isolate, &c, 0, 1)", "str->WriteV2(isolate, 0, 1, &c)"
    inreplace "v8js_class.cc", "SetAlignedPointerInEmbedderData(1, c)",
              "SetAlignedPointerInEmbedderData(1, c, v8::kEmbedderDataTypeTagDefault)"
    inreplace %w[v8js_class.cc v8js_object_export.cc v8js_variables.cc],
              /(v8::External::New\(\(?isolate\)?, (?:Z_OBJ_P\(value\)|\w+))\)/,
              '\1, v8::kExternalPointerTypeTagDefault)'
    inreplace %w[v8js_object_export.cc v8js_variables.cc],
              /((?:data|php_object|ext_tmpl|ext_ce|v8::External::Cast\(\*info\.Data\(\)\))->Value)\(\)/,
              '\1(v8::kExternalPointerTypeTagDefault)'
    inreplace "v8js_variables.cc", "v8js_fetch_php_variable, NULL,", "v8js_fetch_php_variable, nullptr,"
    inreplace "v8js_object_export.cc" do |s|
      s.gsub! "return_value = info.Holder();", "return_value = info.This();"
      s.gsub! "self = info.Holder();", "self = info.This();"
      s.gsub! "self = info.This();\n\tv8::Local<v8::Array> result",
              "self = info.Holder();\n\tv8::Local<v8::Array> result"
    end
    inreplace %w[v8js_array_access.cc v8js_array_access.h v8js_object_export.cc],
              "v8::PropertyCallbackInfo<void>", "v8::PropertyCallbackInfo<v8::Boolean>"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
