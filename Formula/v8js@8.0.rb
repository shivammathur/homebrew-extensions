# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT80 < AbstractPhpExtension
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
    sha256 arm64_ventura:  "d0ca01c79a57042e71d0273b1f2f448eeb843a5d74c6b31dbf4854c39c9fafa2"
    sha256 arm64_monterey: "41813980bbdd19eced14c2b6b59f2b7088a318d17338c726c1e60fa7b0e9a14a"
    sha256 arm64_big_sur:  "29133034f6c2bd8846f747c9766ec4d6091ec06ef61383b8f5ab80c6229eb134"
    sha256 ventura:        "201be435b4fb091789ad40d2c58b552ec4ed945a0a8f5747b3769593349f8cfa"
    sha256 monterey:       "319b1a46662352dffbd11ba99c2d03f39c13526adb45becd1a1226790d6176ef"
    sha256 big_sur:        "ba75d032613e09b072f417ac77935e6813808379cfedab9d05cda5dd7f9777f9"
    sha256 x86_64_linux:   "56856e7d93b4cbaaa5f5cea4b7d148b79362221c2d6c091e50b1743c1237844a"
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
