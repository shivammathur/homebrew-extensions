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
    rebuild 1
    sha256 arm64_monterey: "6408fe033bc4990419267e7d931c2e392971d03052587bc9ddede2eec894bb5e"
    sha256 arm64_big_sur:  "857f631b34017f2ef599523a1da1026fb220b70c4fb6987a0aad06e36f8d9b11"
    sha256 monterey:       "f4f087275e6afab7d84dab9c9d2266a7ad2cac1fc26c2a33f93593224d3277a9"
    sha256 big_sur:        "848c5a3e394539819e5956d4ae50004ca17e04c3ce5eefd218b6d58a7008318a"
    sha256 catalina:       "4a5b0debe515c3596075e2d35007127cfb19329d423d0406256ee1c140eca20f"
    sha256 x86_64_linux:   "9eaecaa8429c774ca4389b846670755dcb3bf6d15699be7f82f6e8b836e5e360"
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
