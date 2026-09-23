# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT87 < AbstractPhpExtension
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
    sha256 arm64_golden_gate: "ffd2caaccb977616c49753f63390d05bc93fc56deb3ee1712a88e80a2118ccc5"
    sha256 arm64_tahoe:       "62fb3837cdf19a69903a924aef8c13a634fc2eec5de5dc7fbf1fb9cf34ec5427"
    sha256 arm64_sequoia:     "7b7699d15115d24fd491f43442ab0c0111394ec6cf83d82031123c0f76d04153"
    sha256 arm64_linux:       "e4cc47ac5c2cee13ccb1050ccd934739db4978484c0b477e3e4d179254628c0a"
    sha256 x86_64_linux:      "95b318d20fd31ef8f0cc5c55582210ad3db3a58f5e5e760f4020643714d0a0c9"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Utils::Path.formula_opt_prefix("v8")}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS -DV8_CPPGC_MICROTASK_QUEUE"
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
    inreplace "v8js_array_access.cc", "info.This()", "info.Holder()"
    inreplace "v8js_array_access.cc", "zval_dtor(&fci.function_name);", "zval_ptr_dtor(&fci.function_name);"
    inreplace "v8js_convert.cc", "zval_dtor(&dtval);", "zval_ptr_dtor(&dtval);"
    inreplace "v8js_object_export.cc",
              "self = info.This();\n\tv8::Local<v8::Array> result",
              "self = info.Holder();\n\tv8::Local<v8::Array> result"
    %w[GETTER SETTER QUERY DELETER].each do |prop|
      inreplace "v8js_object_export.cc",
                "info.This(), property, V8JS_PROP_#{prop}",
                "info.Holder(), property, V8JS_PROP_#{prop}"
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
    inreplace "v8js_class.cc", "SetAlignedPointerInEmbedderData(1, c)",
              "SetAlignedPointerInEmbedderData(1, c, v8::kEmbedderDataTypeTagDefault)"
    inreplace "v8js_v8.h", "v8::PropertyCallbackInfo<void>", "v8::PropertyCallbackInfo<v8::Boolean>"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end

  test do
    (testpath/"test.php").write <<~PHP
      <?php
      for ($i = 0; $i < 10; $i++) {
          $v8 = new V8Js();
          $v8->double = static fn($value) => 2 * $value;
          $v8->executeString('globalThis.answer = 0; Promise.resolve(21).then(value => answer = PHP.double(value));');
          if ($v8->executeString('answer') !== 42) { exit(1); }
          unset($v8);
          gc_collect_cycles();
      }
      echo "V8 callbacks and promises OK\\n";
    PHP
    assert_match "V8 callbacks and promises OK",
                 shell_output("#{formula_opt_bin(php_formula)}/php -n -d extension=#{prefix}/v8js.so " \
                              "#{testpath}/test.php")
  end
end
