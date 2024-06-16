# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT70 < AbstractPhpExtension
  init
  desc "V8js PHP extension"
  homepage "https://github.com/phpv8/v8js"
  url "https://github.com/phpv8/v8js/archive/9afd1a941eb65c02a076550fa7fa4648c6087b03.tar.gz"
  version "2.1.2"
  sha256 "505416bc7db6fed9d52ff5e6ca0cafe613a86b4a73c4630d777ae7e89db59250"
  head "https://github.com/phpv8/v8js.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 arm64_ventura:  "dd7acc87f36ecfce26d2e33fd76794ee4ece5f144f19a0317a3c2ed5184a182e"
    sha256 arm64_monterey: "798f89c13a831c6b1f592a2b582a40c28b251870b831eecdeac6bee7e1680f7c"
    sha256 arm64_big_sur:  "33aa71c3248c5168ece1365596111e528fcae4d2a4da8745e442690b30e7cbd9"
    sha256 ventura:        "d6f912b14f1c8c9aeaa79c553c2874d0569de0439a2f21cd39c144726c6a1ff7"
    sha256 monterey:       "bbd822f85d77189c4738a00bb82ae1ff08d7f6de7419ec30963f9bfae0eeee7a"
    sha256 big_sur:        "d2c2fae0fd8b8a2b92ae370e76c3028058d7a783d1501654d44a0ba55de4bd5b"
    sha256 x86_64_linux:   "6e8d5350b7b38eb5fe3715aba1be4935cf24b055ea0514cb863bb9e5a66cbd68"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
    ENV.append "CPPFLAGS", "-DV8_ENABLE_SANDBOX"
    ENV.append "CXXFLAGS", "-Wno-c++11-narrowing -Wno-deprecated-register -Wno-register"
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
