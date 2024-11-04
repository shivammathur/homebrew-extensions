# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT70 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "3fbf2d3a7ebaac762508aa067d9a419cdc4021f28b979be512e6106aa8651125"
    sha256 cellar: :any,                 arm64_sonoma:  "6f6306363a0a63f86b32a5979cf2e4a96937c8c0f227fa7f22e46e3d9fbd4d4c"
    sha256 cellar: :any,                 arm64_ventura: "2757ef75047d08b4fae6f7ff093cfb11af9183579c006d16012cfbd0cd76974e"
    sha256 cellar: :any,                 ventura:       "5e3f9dbfd684eb9c3674ea3318dd60e705b5c29241c3b9953e684d4d14bf8c2d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "89dd80bd24e9712be4261331807c82988915820b54993737e9d82686c2c3e1fa"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
