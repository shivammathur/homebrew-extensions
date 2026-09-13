# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT72 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "d1a9abb50f9d60c43839b6ccb5c2f57dea06113df4cd4923d0caf4c04e20412e"
    sha256 arm64_sequoia: "0d606554ef24ce3a0ba24845d45ee46646cf990feba22be29e03f28c1ce8edf4"
    sha256 arm64_sonoma:  "1d3828367860e12ed15332f7b09c649effeca86ed5eb085b6bcf260e1f79b331"
    sha256 sonoma:        "e9a68609bec168bf58ad7166b7c9d987b431c67722093c73e0cc9d108649fff5"
    sha256 arm64_linux:   "714ada690ac9072d473172dde9680d00425140986c897602463dd8f10c588139"
    sha256 x86_64_linux:  "cb76ed9929149b65a97513ecc15c29212e8db6a29c15a51e00555b627bd6bb58"
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
