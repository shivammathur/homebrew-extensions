# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT80 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "722b77c66d30083643003f2132ffb0af893a8d4511d8e4c132b7b63a44474a64"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e020fdd6281a85dea0631f250e0b02dd1dfb8e509c9070c2c3dcbdd214f5874d"
    sha256 cellar: :any_skip_relocation, monterey:       "f5fc50d931c6696af41ff36a7e01d29682719320c625b7c6df085fa40f866e1e"
    sha256 cellar: :any_skip_relocation, big_sur:        "3ffe71734b2f5fe8aa078db90922f1d6744debaf05f679d79ccfc7559918cfde"
    sha256 cellar: :any_skip_relocation, catalina:       "bb1e97edebbb93a32e1fc1a26bc1258464c2d2d5c992818f6848d7091c0d47bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7803c182b3d2433812027f5658821a20354c53e0583505bfe0ba776c35688c72"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
