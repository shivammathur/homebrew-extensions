# typed: true
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
    rebuild 3
    sha256 arm64_sonoma:   "6cfaee0a69b0a6f9ace848a5e4bebd208fbec8298a887e73863dbb2fcdc0a608"
    sha256 arm64_ventura:  "a62bebf89a3d249e2a45f46992a7f2d2de8a4889c898c53e1f7ae21b29b85ab7"
    sha256 arm64_monterey: "20a10de2b6eda9e3c15b52e95fab18e8c3853b15c8e84bc16bc423159165f5ec"
    sha256 ventura:        "26ad1315f3dde1dec61dc9cf2ae12eae60d59de1778a1531e1fb7668b1cc5456"
    sha256 monterey:       "b85e73c474a6f789dad0814ed88612feca4c9d0ed534494ef91392532dac8862"
    sha256 x86_64_linux:   "fc283f77593a47a4f2bcada571cc632263f0609630c63188e17180d88bead968"
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
    inreplace "v8js_variables.cc", "v8::PROHIBITS_OVERWRITING", "v8::DEFAULT"
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
