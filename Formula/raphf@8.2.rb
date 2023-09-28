# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT82 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "af2fcbbae06a01d2c61cca272c8181da918e3cd2c9df3b3ca67d1731c8f6d62e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "299d4dda5abe9ebc262fd3085f87a98bcece2d8c2909d2ba043996d811139a74"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f8a47e64ebdc4d6c639e5890639fe53bc677aba19575d6d190ff4cc1ecfecf78"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d3e943e7690e1fc776a593bc3f0d71b0837d93c64daacf826e0db65b2e497d02"
    sha256 cellar: :any_skip_relocation, ventura:        "7eb7759a689296b696dfa0b09216cc6ad401601ffff255740bc4ebec29592884"
    sha256 cellar: :any_skip_relocation, monterey:       "4f57442ca97dad76e5d94791dd3b8391d08e7f80b3613f3c18c112426b69171b"
    sha256 cellar: :any_skip_relocation, big_sur:        "a9cc999f73a5ba40087c152dfd09481b1505e51d4283399f3830bbd7d0ce545a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1c6dfdd4739b5689a684d3229a7033d8855d19ee236f8c45b8253aacd367d52"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
