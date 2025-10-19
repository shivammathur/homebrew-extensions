# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT81 < AbstractPhpExtension
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
    sha256 arm64_tahoe:   "1050749f6683ad8783a637035001f907aeb4861596a905e817cb6c9233e01b95"
    sha256 arm64_sequoia: "e04ca706f7307c1fa2ca452086817bfb9e93c3e70184b05ce985637daec09a76"
    sha256 arm64_sonoma:  "a5584a7ccec4c895b8f483938e57801309a05b853bfc3a42596908d6b8e6451e"
    sha256 sonoma:        "6e113d1864f2c588addcb6f4940d8ceba3b341fd71b9bba3bee0d79e9d94beac"
    sha256 arm64_linux:   "db4487dc57c52623708eb58ee7aa4df2abc568f7e10ad21223056d48e3079fb0"
    sha256 x86_64_linux:  "906669044a8564b234631361516a2458a22cb4f20bfdbc08d9f776254d6204e1"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
