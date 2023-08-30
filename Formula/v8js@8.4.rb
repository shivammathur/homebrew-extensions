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
    sha256 arm64_monterey: "ba4902a701e7683b335768a307bdedbba09df2784d6257a7ada3fa6d9c0f5d82"
    sha256 arm64_big_sur:  "16fd2eb3bc5f33e322b1cc43686c3293e7d7e54ced1339ab1ce82214a6e74fa8"
    sha256 ventura:        "08f08146c49171b93fd82d3393ba9750aa32b2a058e727adbe4fc02feef0686e"
    sha256 monterey:       "637f3d0549a1d063ce9043a09ff8ab9b6f4ba66ddd285d657bd8c2993fc40134"
    sha256 big_sur:        "103a5c14757b99eaa4f57b3e9cb22d83b5d33ab7c8f9e3617e7449a2f4f33c5a"
    sha256 x86_64_linux:   "3b7fffe8232999b3212dc633a71713b005d4011df80ba31287f47901fc76a539"
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
