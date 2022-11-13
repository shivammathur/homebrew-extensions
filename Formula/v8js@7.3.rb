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
    rebuild 1
    sha256 arm64_monterey: "56e9ce003524db1b21711002f10e75b0b6a0748f733b8deeb5264e480942acea"
    sha256 arm64_big_sur:  "ba4c3ca963df072b0d443fb99c5193c68a2ca5cd759ff19fb15cefc5f2e76722"
    sha256 monterey:       "47d136aac82ffb88cc523a165e6973010dd0652b4b8649b28f3323150dd6a8b9"
    sha256 big_sur:        "84dd4961caeb7e1b45026b94a7dd1c94952d9ad8160b9e2bce3342166ec379f9"
    sha256 catalina:       "c93fac7e739829930093cd4d9c357049bd096f36f9b86c4067db96bf49e6d4b1"
    sha256 x86_64_linux:   "cbcd775146dfd6332e95459cb1030d90767d7bac869c4e7feecae69b405e7b32"
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
