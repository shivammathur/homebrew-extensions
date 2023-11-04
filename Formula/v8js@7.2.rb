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
    rebuild 4
    sha256 arm64_sonoma:   "d00f6ac7a867cdefcd39b8ae5219b675c58e480de62fa7d54a14af8050ac4e3c"
    sha256 arm64_ventura:  "84e2d85a3fa8cdc6840f77f8d670ad061137d28dcb5fa530ee0ac1d5f7506b0c"
    sha256 arm64_monterey: "e6973cc00bb649973cf9c4d55c2b6f9e60a5135982ed9ae7c1e88c1315e54070"
    sha256 ventura:        "d07385e52161ae11e2933767244939aeba7bc0a907cf5537ed1087dc7a4a2bbf"
    sha256 monterey:       "edc28342d0acc962fca7fbf499f65ed221b707ff94685bc6b07a26f2deb32526"
    sha256 x86_64_linux:   "af5bfa0b0643bcb82e6273212e0f89d1eaded7561e374ca7b1d76748117f2e1b"
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
