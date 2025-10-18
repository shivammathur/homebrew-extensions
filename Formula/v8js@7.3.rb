# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT73 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git", branch: "php7"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_sonoma:   "4f7e2f83c3eabae8ff1ea9e5af1e595e7707d045a51d8d07c18a73460f7d2545"
    sha256 arm64_ventura:  "553dc263bc6266a7aca0f4f80c4155d7786207035d08aa6b23796ab8234b92ec"
    sha256 arm64_monterey: "c67b3186fdec524fb53f2cd14d9889a37810c5bb5a707ca22daa9935db570dc8"
    sha256 ventura:        "41e1db1dfde743e687ef1fda806b9c4f74d267744b4bb9ff7f2e1996b701d2bc"
    sha256 monterey:       "41d718378285f457455e43a41b93e17ebbbb5ff62e58173a5b276013523ef02f"
    sha256 x86_64_linux:   "a61b57b57be554729bdb3ac3d1fbad25f5a0d9e2fb7faf6f763755bc82012809"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
