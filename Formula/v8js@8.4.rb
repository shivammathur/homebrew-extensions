# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT84 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/7c40690ec0bb6df72a2ff7eaa510afc7f0adb8a7.tar.gz"
  version "2.1.2"
  sha256 "389cd0810f4330b7e503510892a00902ca3a481dc74423802e06decff966881f"
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_monterey: "803a505677447c15a6a94be3fe9fae218600fc92a8812cd1f979ca15223b03b6"
    sha256 arm64_big_sur:  "b5df31fdd19b4bff2ee2790836686b32b18501b305feb3ecb98978c24ec8f5e4"
    sha256 ventura:        "ebb3f65c5330f7f14d30416824ab860eeb6dbc51b2d6fefeac147a6e7daa1d46"
    sha256 monterey:       "e6d14a22938665dafbd133ff25793efbe21cc8888cf94649c219821182d531a3"
    sha256 big_sur:        "3f6a2f401cc0ff21f8d8603f01734d7cf371164e7acca3f277aba1a59cf264bd"
    sha256 x86_64_linux:   "1e155d6a2152c2d78c9f9ddb2c46575551d9e5897ed59a9a0b00d9fe2942ebfd"
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
    inreplace "v8js_v8object_class.cc", "static int v8js_v8object_get" \
                                      , "static zend_result v8js_v8object_get"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
