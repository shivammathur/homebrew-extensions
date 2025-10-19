# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT72 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/shivammathur/v8js"
  url "https://github.com/shivammathur/v8js/archive/1777ce3d774747075432672977ca4e034813575a.tar.gz"
  version "2.1.2"
  sha256 "1064d6ec32c5e8699928f541607f709e3bf1da959ec0cd8bedb62b4a87dca8b7"
  head "https://github.com/shivammathur/v8js.git", branch: "php7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_sonoma:   "b8753ba7ab9042883a01936b14a2ae61c41c9c4528867e0c10c92b76c332a767"
    sha256 arm64_ventura:  "7d13aa64b39329c92db156b9a4a7c0789d6497f8e056354977d563a47946875a"
    sha256 arm64_monterey: "2aafc20076db554654dadb39a4acce455734599bd1e43d0e2cc6a98d6d6a7df2"
    sha256 ventura:        "083beea66cb50bee34d7e4877c269a61ed94c06ae0f8e1c23ec65999c6d6020b"
    sha256 monterey:       "bb337108eaef7c999f522c921cc2c962c395e41f9f5ef8e91b061b8568a76ecb"
    sha256 x86_64_linux:   "34a00a1ff9c9678d3a97e694d78cce06ea1ba4468d6fd1633c33a3667f721004"
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
    inreplace "config.m4", "c++17", "c++20"
    inreplace "v8js_object_export.cc", "info.Holder()", "info.This()"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
