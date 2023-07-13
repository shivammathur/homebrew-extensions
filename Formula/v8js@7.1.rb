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
    rebuild 3
    sha256 arm64_monterey: "93667f96d668bf3fd429404cb979627f24be39b54ec3bdb79c5b4e8aee7c550e"
    sha256 arm64_big_sur:  "463ad92d792651c0afe921c3cd1bdbe7481051a2d79d2c58eb1c2cf605ab4ca4"
    sha256 ventura:        "adfbccaab43a176162bc5e770b07a8dd1b10b44376dd7328748bc1776dd91b51"
    sha256 monterey:       "59a03b7005ecb1664c54bb4a0c3b1e017bf1839b59dfe23c9e7184602a10cba7"
    sha256 big_sur:        "cb9a32dc34c3ef812f128e633739b6333c9c4c39407b86e4462761aaecfb82b0"
    sha256 x86_64_linux:   "96b8ecec973816c4054da921717f0664320feb4830f19171f56ef80b8fd226b2"
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
