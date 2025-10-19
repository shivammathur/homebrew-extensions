# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT74 < AbstractPhpExtension
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
    rebuild 6
    sha256 arm64_tahoe:   "23104b5453fe4f885c84e5292c15001b928a76317edde262cfaeaf1c01cb9fa7"
    sha256 arm64_sequoia: "f2d25cca26336c23c0b2ed96e3cee178aa3552cef6e744e7349b7421b7594cf8"
    sha256 arm64_sonoma:  "5b9a1d56bdf2815ab25b8db30e32c7adf352ebf4efb987ce7b3712e88eafb334"
    sha256 sonoma:        "a9e050441999728cd6a1c54c576f2939b69678072a93832d1b3f367093a012f8"
    sha256 arm64_linux:   "a2230c52d880c0117ac845368da3ce91c3e7637e1d43aa4724f4811c6fce3890"
    sha256 x86_64_linux:  "4eec72bce9275f15235c0a0c06a6d814e75b7dea779e786981ea6855fd657884"
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
