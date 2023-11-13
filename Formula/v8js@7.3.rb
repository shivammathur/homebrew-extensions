# typed: true
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
    rebuild 4
    sha256 arm64_ventura:  "eec8dedb4fd9d853ec9f6b5432da34e23c0da8be8c6d6dbaf7360475704d4195"
    sha256 arm64_monterey: "e4a0f5f5ab33fb3e501c8a6726df7a0a9fb015a1a3c65af7482ce85ced812ace"
    sha256 arm64_big_sur:  "bf11c7c6d13b71c61b8c6eae48362e60f62ee4b0124cb6d0f62399ed1d46f8d8"
    sha256 ventura:        "6c0eacb9e63a411de018098b984d9ca8467300864ef8c55b549bc8b764babc9b"
    sha256 monterey:       "a96e1c9953acce7d1b477d92796bd061035189646850e986cd03f568dbb6efb6"
    sha256 big_sur:        "21be9780c73e48867c7e81f6a928308198ef562f96902604332863be59951904"
    sha256 x86_64_linux:   "ebcbd50a02381b9a36d03ccf06f6f5bb4c2a4fd3372d8dba514a780d5982fce1"
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
