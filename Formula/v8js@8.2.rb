# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT82 < AbstractPhpExtension
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
    rebuild 1
    sha256 arm64_monterey: "fc3a5170d9c7435d3ae74d6d9a3bfd7aa19ae65639113fb9c4e1cf4ea3b4d608"
    sha256 arm64_big_sur:  "3845026f985169fca505aec716b79446f9da59142f8801dc8348a0e34668a7a5"
    sha256 monterey:       "b2184fb11ea67c2f5c63821768cb02a7e2fe1896e8bca5f5d822303b496dd335"
    sha256 big_sur:        "8fd6b5e5113f05c72739c7e4e55500b30f938caaae88f803d189cc08e99b86ac"
    sha256 catalina:       "498e2c1c7ac026bfc73792204b7b8787de84169fbf92f2fc3341446553a38db9"
    sha256 x86_64_linux:   "e6d799d00f296e096a5b839df75a78a8315d6cf0964f4e56d094b704094ecfda"
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
