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
    rebuild 2
    sha256 arm64_monterey: "8f7f0ca8444ae488a192bc6180ce442f44cbc489940a83457c48ad7fb3996126"
    sha256 arm64_big_sur:  "976cf7ccab8b847410d729b20a9b18baeeeda896f5395cb2ac91a2b5c8e3a226"
    sha256 ventura:        "fae793a04dfddc8fe3910844bf334c2799cd6e219fcade0896ef5aad1d67bd03"
    sha256 monterey:       "d8fdf272cde5b1faa43565132bc50db542bd5995ea44ec0638c53918b7e073dc"
    sha256 big_sur:        "98df72c3339068dbaf4ff6efe77e9af060a2a0cf6b479ac44600ca0ba81ddbe0"
    sha256 x86_64_linux:   "43f273a81c2053963411fe96e7c1a4bc435d517d68fd667b0ecf7d3dcb550bed"
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
