# typed: true
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
    rebuild 4
    sha256 arm64_ventura:  "84400ae3a367698daa1abe89b3c60ee4ab4b602ca5a3fe836d1658254254a39b"
    sha256 arm64_monterey: "6e8f09fc906628518ecda16cd09847ec24b49f4cf18db61270ddec3510f6f965"
    sha256 arm64_big_sur:  "56bedbf7bb3ed26cd012c85965f939fe716212f50f037fbdeb0f27e113062782"
    sha256 ventura:        "acd9985db22168f06b3b2adf4171efd71de9a63c3dd47e56aefb0f011ed7bce9"
    sha256 monterey:       "9e63513f2b4ca14c599069e5d3d1d6aa590aa25d7e49e0592094b082c88ee406"
    sha256 big_sur:        "d2999a8cf8896d7510386ce492212a11f19eff1cfda1236e5484fe4d3deeb919"
    sha256 x86_64_linux:   "bcae3350cad2b61202a65887d288e634a55bf33d721bac0e48714be0b34aabf8"
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
