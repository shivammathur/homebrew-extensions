# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT74 < AbstractPhpExtension
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
    sha256 arm64_ventura:  "06594011aa9186b40694522134232a1960b50d8630f91ecd9e35b0e9eefba3d9"
    sha256 arm64_monterey: "000de54fe2cc71c57752300decef2e2dbd67e29ded966f68cb72a23750302d14"
    sha256 arm64_big_sur:  "14a756a183e3cb45a3e829712d9ce27218700a86b7e5f12e31dc73e87924337b"
    sha256 ventura:        "b475c96093d90d31fa3c37c912bd283b6fc8d97ca71ff2e4c1506da94c69be9a"
    sha256 monterey:       "538ba7c70bfa5b587f30b8174d3ca9aa4d9880b47191f7adde2e3385ace9556f"
    sha256 big_sur:        "051f18bd26fb6777a95f1333a92af77bffa2ab7f8cf05fbc04e23bdcc3896436"
    sha256 x86_64_linux:   "4ad3597822787495a66751cfcfa217c72fe711d53f6a270e339549319db60ed5"
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
