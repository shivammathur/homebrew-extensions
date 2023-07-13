# typed: false
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
    rebuild 2
    sha256 arm64_monterey: "75c6dbbfdee86565dedc4fa6d70448d9eaa14bb8cee2c3c58e7267375fed5de1"
    sha256 arm64_big_sur:  "4a66e48a7d9de9c9318266cb74e7155978cbb0aca22bccb45219e167fbfd71b7"
    sha256 ventura:        "bea93e5b35a898c352acec813b38a902b54c030a264eda7e60e1b598b97e4b4b"
    sha256 monterey:       "e0db4f0fba5c0808ceda12b83eec624a4aadf02924d93626ee8c7bee69bb5550"
    sha256 big_sur:        "8b24b10e50e5f664c78f77be54402bd32a006af5380c633021f86302e28e4a21"
    sha256 x86_64_linux:   "4d9e07b3730fbb3c61d1073d81bdead7ba6320b60204d26eaa27a78549cc8ef1"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
