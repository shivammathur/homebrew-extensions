# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT86 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/8a39efa3cf3b275e402ddf3c4f6b611a5f69a499.tar.gz"
  version "2.1.2"
  sha256 "0a03e4b4ccb5755aaa0c9d65afb5906827395826641f2bad1c19291fce65ed2f"
  revision 1
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_tahoe:   "2d23cc1ca3fc7f2b1bb44b54c8b52ca3e78d99fc2ac378152983bcdf8fd842ba"
    sha256 arm64_sequoia: "486751bd7568e2da0fe618e64c494622ce0d1c588db17c4829b9d2254a2e8fca"
    sha256 arm64_sonoma:  "920dc177be12670ca9aaad5d637715e4f0f1e7eb07c6977b0b05559cadb16f9f"
    sha256 sonoma:        "9906abe380fce2310619994e889b8ee1e4afd423094b8bb1cb6e918104d761f7"
    sha256 arm64_linux:   "4036c69805b9fdbf004089c25162b6953af4079857d699d940a9a3df736ce58f"
    sha256 x86_64_linux:  "3c195878417f9a61ce6f11985340243e6dfd28e1009722c521275e3d7691e9b9"
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
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    inreplace %w[
      v8js_class.cc
      v8js_class.h
      v8js_v8object_class.cc
      v8js_v8object_class.h
    ], "XtOffsetOf", "offsetof"
    inreplace "v8js_array_access.cc", "info.This()", "info.HolderV2()"
    inreplace "v8js_array_access.cc", "arr->GetPrototype()", "arr->GetPrototypeV2()"
    inreplace "v8js_array_access.cc", "zval_dtor(&fci.function_name);", "zval_ptr_dtor(&fci.function_name);"
    inreplace "v8js_convert.cc", "zval_dtor(&dtval);", "zval_ptr_dtor(&dtval);"
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
    inreplace "v8js_object_export.cc" do |s|
      s.gsub! "v8::External::New((isolate), mptr)",
              "v8::External::New((isolate), mptr, v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::New((isolate), method_ptr)",
              "v8::External::New((isolate), method_ptr, v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::New(isolate, persist_tpl_)",
              "v8::External::New(isolate, persist_tpl_, v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::New(isolate, ce)",
              "v8::External::New(isolate, ce, v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::New(isolate, Z_OBJ_P(value))",
              "v8::External::New(isolate, Z_OBJ_P(value), v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::New((isolate), jsonserialize_method_ptr)",
              "v8::External::New((isolate), jsonserialize_method_ptr, v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::Cast(*info.Data())->Value()",
              "v8::External::Cast(*info.Data())->Value(v8::kExternalPointerTypeTagDefault)"
      s.gsub! "php_object->Value()", "php_object->Value(v8::kExternalPointerTypeTagDefault)"
      s.gsub! "ext_tmpl->Value()", "ext_tmpl->Value(v8::kExternalPointerTypeTagDefault)"
      s.gsub! "ext_ce->Value()", "ext_ce->Value(v8::kExternalPointerTypeTagDefault)"
    end
    inreplace "v8js_class.cc",
              "v8::External::New((isolate), method_ptr)",
              "v8::External::New((isolate), method_ptr, v8::kExternalPointerTypeTagDefault)"
    inreplace "v8js_variables.cc" do |s|
      s.gsub! "v8js_fetch_php_variable, NULL,", "v8js_fetch_php_variable, nullptr,"
      s.gsub! "data->Value()", "data->Value(v8::kExternalPointerTypeTagDefault)"
      s.gsub! "v8::External::New(isolate, ctx)",
              "v8::External::New(isolate, ctx, v8::kExternalPointerTypeTagDefault)"
    end
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
              "SetAlignedPointerInInternalField(" \
              "0, ext_tmpl->Value(v8::kExternalPointerTypeTagDefault))",
              "SetAlignedPointerInInternalField(" \
              "0, ext_tmpl->Value(v8::kExternalPointerTypeTagDefault), v8::kEmbedderDataTypeTagDefault)"
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
