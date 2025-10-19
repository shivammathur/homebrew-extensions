# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT85 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "6d656df4f1df60817c19a4d6ff83ddc4bd8c6ba62280a20424fd123e45506565"
    sha256 arm64_sequoia: "77a8012195fc69281177d5fe7af95d633f2420f8d3a5c39adff7fa729a1b2487"
    sha256 arm64_sonoma:  "ffade468ca87f8b8108889753324249342618c60d5aa1cc0885e3e3f868e5621"
    sha256 sonoma:        "63ddd2a60ea82240bb81f8c8112ffaa460676dcaff3c3d266d997a69956ff284"
    sha256 arm64_linux:   "97767d1dd57eedbd9aac3f5de477838e761a91354e35ae5042a2bfd21dfa1070"
    sha256 x86_64_linux:  "ea1c59b76a5d8faa814325ae9671b35cb9f977b81a69cd4e23a359227eba7ee2"
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
    inreplace "v8js_exceptions.cc", "zend_exception_get_default()", "zend_ce_exception"
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
