# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT73 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_monterey: "d7f7d7238c1d8c9ac525d8844213f28bb62b62f54860a434cdcd339509c17f93"
    sha256 arm64_big_sur:  "7b857719fe28ace3ce9e0820ef8f3de4074345f95402c6d6dddf1084fe4ac538"
    sha256 ventura:        "37019e2f2154eb337645647559d76dd5c30e7e90d463512ac273cb52b9bc2eb5"
    sha256 monterey:       "6f944d773906543662d01f7a74457db0c56416abea7dc753d501c94a740a2510"
    sha256 big_sur:        "3090df1075cea47e74075f5d026ab4336f0b671f1b29f18ab748dd572fdae9ef"
    sha256 x86_64_linux:   "4927a0b18f1410e4b3e29562dc4c4367cf2337ab7b8845aaf733736f2d31a68c"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
