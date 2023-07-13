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
    rebuild 2
    sha256 arm64_monterey: "1d08a819615085c11238808e09091eddaba645348893762927ce5cde0fbac59b"
    sha256 arm64_big_sur:  "e4c8dc8fed65c899b3ff1beeb983af4882684b2ee2cab2ffab47ed25a1ffe418"
    sha256 ventura:        "2dff6bf052d177e026e30212cf1749c2cbf30ffc0858424f55c5a7ba0a557fcc"
    sha256 monterey:       "69a5daf7fde474926345918dee3294e961e120a3e2dfabf7167083688c29e06a"
    sha256 big_sur:        "66564c24df61143fe1598de89aeecdb78d19b9c40c58bcf916de380acbdb0884"
    sha256 x86_64_linux:   "f534c641f9e7d894a292107d8ba2e5f2f755dcf306bc3fc522c531e965dbb4b3"
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
