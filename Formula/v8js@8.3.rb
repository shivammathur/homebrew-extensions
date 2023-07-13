# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT83 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/7c40690ec0bb6df72a2ff7eaa510afc7f0adb8a7.tar.gz"
  version "2.1.2"
  sha256 "389cd0810f4330b7e503510892a00902ca3a481dc74423802e06decff966881f"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 arm64_monterey: "b892c0b0e4c0a0b77796096f6c3f7bbc583e56f1288e859b4002f292f44535a3"
    sha256 arm64_big_sur:  "2b7f193c9a0df20d6fd2f4f89c0e577384b2593b31af34bef1c3e451781940e8"
    sha256 ventura:        "b3b4fbec9cebd4971c0ba890131031d289fe13a0a631918f9c085c11ae244467"
    sha256 monterey:       "1caeb1489348ecdb0caa6446797a42b860e1c009624304a96bb8bb041008e844"
    sha256 big_sur:        "16bfea3b2a30cff2bc33b2955d2629551307063c05e7a5421b3d501248da487f"
    sha256 x86_64_linux:   "49bb7da313cb349d6ca050366280a09b5136995cdb2ca2cd486c1c2401a9f858"
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
