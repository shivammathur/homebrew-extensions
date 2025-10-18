# typed: true
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
  head "https://github.com/phpv8/v8js.git", branch: "php8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 arm64_sonoma:   "aa8f0161a1204d6b304c315528dd07fd12c3486b7081083aaece629c5cc17c5a"
    sha256 arm64_ventura:  "904490bb6a745acfe767aa1d9328489970767512de02d8590469c01499c6e052"
    sha256 arm64_monterey: "c562ae49f2a10cf977db0ecf3feaeb7a7a5f3320a04b523a1717dd197b8f169f"
    sha256 ventura:        "cd4735397f5e5924993e0f78389f7e37102636da7e9c3fb4b7fcec3b3d30b834"
    sha256 monterey:       "d7ae16142ca95e5fb33e029c6cd554647def9845076d13e442c1fec8ca338003"
    sha256 x86_64_linux:   "f338c5c91522536b6d5b8778a9f86735c24142c8af51d0e5408dc6d47126376f"
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
    inreplace "v8js_variables.cc", ", v8::PROHIBITS_OVERWRITING, v8::ReadOnly", ""
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
