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
    rebuild 5
    sha256 arm64_ventura:  "5f24d86023f07ae5b6d053ddfec6c57b891cce4ade9db792c826835bb900d4bb"
    sha256 arm64_monterey: "9b85b33e9b50c3bd0d2fd648193961af0152d4ae29fa0747b6e98c76c8d46f66"
    sha256 arm64_big_sur:  "7c724093930cd2b37fa59b0be371f83c17099e876222ca15ac47094b48b7767b"
    sha256 ventura:        "af973b491cee9d68b854455904de03d11b21298cb93e806c553332029dba4433"
    sha256 monterey:       "9c0514b3395fe61f8af57d28dd9c2a64287d3d293530b3b886eeb9c2b46cec70"
    sha256 big_sur:        "afbd7884baf3c82e94c4ee1f49a6695f94290b686db8fecedff704676ec318c3"
    sha256 x86_64_linux:   "0750ea782fe3e66a6f81d42ae75e9f75fdf95ae0098c8efa323a21a5aaa865d6"
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
