# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT71 < AbstractPhpExtension
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
    rebuild 6
    sha256 arm64_golden_gate: "1e86fe20fb8c550286b30f55ee61a59b0a23f3b75518486bfd5073db4af96e4d"
    sha256 arm64_tahoe:       "2cbd61fed77ef37a5a641dc93956853f613b098295a61ab04a896685114cb102"
    sha256 arm64_sequoia:     "38eb005a81cb12a1163e4aeedc3ee4dc8791181a42f48c27d2f8c3608eeb0b71"
    sha256 arm64_sonoma:      "0c29105e8f59e0153f06d9794ed8e06adb347310c48f026e0c01c32489b1bbe7"
    sha256 sonoma:            "047d92c262907cf0c6f3895d449ebff9907738f07fc64a8206c37ced1e951f68"
    sha256 arm64_linux:       "c1ff7674b60cf1445932211e13c878714e5733839e647d71e84b4cf1fc3b7571"
    sha256 x86_64_linux:      "70f98d01645fc806d7fc461e9e11fa72d9538e95855174dcca402fc534556722"
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
