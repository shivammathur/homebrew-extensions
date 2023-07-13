# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT71 < AbstractPhpExtension
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
    rebuild 2
    sha256 arm64_monterey: "4da9e78f01b2df2579b1fd96c7b8d67bc529c6d3424aa9701fd180f838085eb1"
    sha256 arm64_big_sur:  "308d06c703cfda65b683529bb6733dae1d7b46be05c922f5f26d33bc6ae79c0f"
    sha256 ventura:        "29c17be4caa25b8c7c4fecf633be85fa9ae3fe0c17a2f83544117a1448ca86df"
    sha256 monterey:       "667629c71802fc6f134e8e5f94016cb07700b7e043665945c80712ee7820d6d0"
    sha256 big_sur:        "2e6338d70c848053d404a63f0b8e8d8cea8b5be03725dab27e63185972ac1adb"
    sha256 x86_64_linux:   "154be95c444c6fe5e4d299aca85f46393dd159ac12edad8a83f15120d8bc2e5d"
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
