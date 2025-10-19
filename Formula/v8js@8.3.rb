# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT83 < AbstractPhpExtension
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
    rebuild 8
    sha256 arm64_tahoe:   "b456c011499a51aac12f0fb47e92201c8d28d039b1660ce7f3cc69a7eaf427b3"
    sha256 arm64_sequoia: "804476a1a807cdaa5537c0f22eb0e84657714dc9c7b3f73ddcfd728e143a2c0b"
    sha256 arm64_sonoma:  "2032e5407dfd6fdf0f11a9cf366b545f14e8ea721514b8b375783cd75645de04"
    sha256 sonoma:        "5842ab8e735ba8a1de98c92e1c8e0add74e7c112d8c50baf0f10900cf5f8e457"
    sha256 arm64_linux:   "0cb7573db54a426d0a2dfcb12df92184189ff08dc022d57aad13d63aac87065b"
    sha256 x86_64_linux:  "81c75dab5c32c7b485cb33562a8423ff29e4d3b2e5d102e2c936d41d8e74759a"
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
