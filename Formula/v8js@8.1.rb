# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT81 < AbstractPhpExtension
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
    sha256 arm64_ventura:  "cf5edf9d0d1ad53e38d0fcf60b0f24f7d471b0430684f54d1a4f3b02e803527c"
    sha256 arm64_monterey: "e5368383fcfefca3419c84c14dbdc57f3415f15771ffc594635d28872674f8f2"
    sha256 arm64_big_sur:  "7101915462bfbb1b5ed6543da3554769c3e88e2e088bcdb9dac12d03e793ec2c"
    sha256 ventura:        "ea8f4b3f8f0b0c6286c86976778bb0def136741f2e581891828d901df7723ea1"
    sha256 monterey:       "4b8e59a73af80df67bf6fe9018f34184252981d964093513ccb2d361f257c154"
    sha256 big_sur:        "337e773755b4ec35e36e0493692630032f266a7c98fcde6ff75e802990b40de3"
    sha256 x86_64_linux:   "539965a3d4b45d522e8161ae00b7a6c8abe4c18ed14fcd19d2f010856ef428be"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
