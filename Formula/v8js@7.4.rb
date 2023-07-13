# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for V8js Extension
class V8jsAT74 < AbstractPhpExtension
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
    rebuild 2
    sha256 arm64_monterey: "1ed9bad4e41ff7c4d130102d4f5ff0a2c636b9900e1281543174136bfecc72ab"
    sha256 arm64_big_sur:  "13a4447c754d9751c1ec6db2349a8382554621c556343ae3ba3e6d0962f294b5"
    sha256 ventura:        "9feffdfb8f42bd98efe0e64dd6c08ab69097259f2e2b5fcc46ace5fed38cc197"
    sha256 monterey:       "bece6198fa63848e8652fd5d1e0dd674e9b339123b5491ac41e5a4d3edb46f0d"
    sha256 big_sur:        "d7f418450e03e6278b5cc5a330aa37c11bb64f9d70ca25f09fb6564a742c23c5"
    sha256 x86_64_linux:   "c8e7e8e79e387ed2648d1ba5b579d321b015abaf582c144196887dd8fb4e2f5a"
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
