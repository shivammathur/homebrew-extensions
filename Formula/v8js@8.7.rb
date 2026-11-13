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
  revision 2
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_golden_gate: "a38e5c201e652c266814242b21c8019485b97442bead7f64cb08de58035ad8bf"
    sha256 arm64_tahoe:       "3bf072780ebe3ac2b5f38acf73bfa67b0fec26da974601f1a9792f83e0c87ce8"
    sha256 arm64_sequoia:     "e35abb0999aea5a5b843fe82d19135b6c4fda129e70995354d7e359af740b490"
    sha256 arm64_linux:       "9b1585f2bc5821dbf36da19cb017c0410493c16eadbbd27ec6033eb526bcef99"
    sha256 x86_64_linux:      "f7abf8d1048475c7c8a9e9b1f5dd9fa4cd9e0fa70115bff254608e6108de71a4"
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
    # Include child_init_func while keeping the C++20 module initializer positional.
    inreplace "v8js_main.cc", "STANDARD_MODULE_PROPERTIES_EX",
              "nullptr, 0, 0, nullptr, 0, ZEND_MODULE_BUILD_ID"
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
