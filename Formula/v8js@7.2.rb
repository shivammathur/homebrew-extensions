# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT72 < AbstractPhpExtension
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
    rebuild 1
    sha256 arm64_monterey: "79347a1d613cfabd91b4196a985013574cd37fca3c24d4f582f39e02beb6a205"
    sha256 arm64_big_sur:  "32131ea8bf56127922502a444cb66593d182984b8fe43a10d36a89a093179783"
    sha256 monterey:       "7c1570025c62cc645404d380a4677d68ef46f5824989ab4ffbcbfd87f0eb8333"
    sha256 big_sur:        "a0f922fa8cc0d0b1f6e005bcec8efb174b3ee912aad16abdec5228d21240980f"
    sha256 catalina:       "eaba338c131012284dfb8bc519e7e06ac5322e43575a265d6d7d26b9ce4babd0"
    sha256 x86_64_linux:   "92e8d41eb01255da7ed0f2e151e8db2305118bde3bfaf39d241a27bb76edf2cd"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
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
