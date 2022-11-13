# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT71 < AbstractPhpExtension
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
    rebuild 1
    sha256 arm64_monterey: "09aff99ade2be17b9a1b7d2f1ae39584252d8da4ffae118c27525adc269a2bfb"
    sha256 arm64_big_sur:  "9783e1cd40ab40dcce186b1b06d2c4b60b61bb08f07e1a987ba3b2ae3f03d677"
    sha256 monterey:       "a392d3ecb20fb03c1f281705dde531bfbfeaaa2f0bd2e0dd7a053403ec9046b6"
    sha256 big_sur:        "068f26e564a88957e237490161fb6829e544f34807a62289907f1df04823bc97"
    sha256 catalina:       "8da7699637f67d6e22da82560ef8bee76dc2640e819e97214219a34224e537dc"
    sha256 x86_64_linux:   "775388e5511d39f1a0298cc3574df54d5c7979acf658400e9ec48d3b33ab66dd"
  end

  depends_on "v8"

  def install
    args = %W[
      --with-v8js=#{Formula["v8"].opt_prefix}
    ]
    ENV.append "CPPFLAGS", "-DV8_COMPRESS_POINTERS"
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
