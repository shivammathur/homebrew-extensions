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
    rebuild 4
    sha256 arm64_ventura:  "ceb7c37c51675561de299690093a376011c6106c28c150fb540f5804c95c3ff5"
    sha256 arm64_monterey: "bb41731ca8a7ce269eda40ca6f5254d1fe4787725f0d0d345a6f4ded4e2cbaf5"
    sha256 arm64_big_sur:  "5629940bab678dbe861b7ccf7c752760356454cb7c7ce1a8e9f7ea97c102ab17"
    sha256 ventura:        "33ed276a7ef9b410b37ae62b5476c70f812b9f3f291398c685f0c3980f77bd84"
    sha256 monterey:       "493783cf68458ece3f98540729c519b1db1147695454c9cfdf3b948ce5250825"
    sha256 big_sur:        "bbd48a294a6275c9f813f471a1d37da52690e5f2ebdf078db65d35f93e0438a9"
    sha256 x86_64_linux:   "22d9a450408760ae674250c5a871f862ab737e368d82216bf55dd8c531391b97"
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
