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
    rebuild 2
    sha256 arm64_monterey: "823b1774136aaca252434a53b86817b3f7f9ac1620e4b97b08207f8f7f05029a"
    sha256 arm64_big_sur:  "895b77e6dc91e43e699048812d4250b75cfce6bd3d41b4e84de5b2b76ec9bd08"
    sha256 ventura:        "e8d46f8173bf1a8f3f9cc9fabfea56f5f7479eb35a98b18e0e97f83bb5a6a2d4"
    sha256 monterey:       "d19353ec39713ff55dab995383f4918dcd898debab2a29f9593acd5400c65215"
    sha256 big_sur:        "36b50b9d929b16054af82ff5423afbb7b060d63f56ea8f9512d9f073a255d9ff"
    sha256 x86_64_linux:   "ec02a219149a3a1b5ee6fcc4dc9e81d0ee2d654101b1c00245a788b5b4fc7b8d"
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
