# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT82 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/dde1c5a87bf702a6e43a432cd6295abd9867af2b.tar.gz"
  version "2.1.2"
  sha256 "aa392706a4b5672954a1efb4ef8c13136253043257b575abe472a3eb848a7446"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 arm64_tahoe:   "1d3589f3d437e7aef00b96298804ce271551a61bc6971805cec469838a729155"
    sha256 arm64_sequoia: "78b926815634cefcd68532b177f4195cb21816ea8bb346d6e6f00b8941e6b18f"
    sha256 arm64_sonoma:  "a73bcc5082844a572805f06681cbb6857860f0d37d801378f53142e8bf7234e5"
    sha256 sonoma:        "af0f031de45541cd3197fc6d76bfee30fa6dfd766518e1ba9ced7cec3e14a806"
    sha256 arm64_linux:   "feec9d00d8659ad53b654297645f1d8c451ebeee7437467c20e9ce9de48c014b"
    sha256 x86_64_linux:  "25e697881e4598049e634438d237548121a248315c1ae48e8d5babe5897f9406"
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
    inreplace "v8js_object_export.cc", "info.Holder()", "info.This()"
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
