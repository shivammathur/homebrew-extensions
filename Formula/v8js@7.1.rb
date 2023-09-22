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
    rebuild 4
    sha256 arm64_ventura:  "68217dcd9d725f7d22525ae42f217ee18b93d095ef45d95be231e09727b4d62f"
    sha256 arm64_monterey: "98bf314bd57b175d9079dfb248eb061392c09880da42e0915228d836693b0181"
    sha256 arm64_big_sur:  "d85195cad99d84f5e9e42e7e65d49e99d3730c697b45279a39b2705a1e4017da"
    sha256 ventura:        "01557980c96d46370af56cc910b19678854082ce769b593c50c383453f93bceb"
    sha256 monterey:       "6a68ed91ce02314f57c784174a93e999aac3eb7127ab9d6c3a9831812aa09b5b"
    sha256 big_sur:        "c3fd2538147b7d233fb31cb4569f344646f901c2e4bc1d28ac9b6ff66ea58a3a"
    sha256 x86_64_linux:   "8d4c926fe97f993acd0a65e75a56037f479bc86705597e596d6767d362a8c772"
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
