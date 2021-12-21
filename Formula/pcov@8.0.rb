# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT80 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8dfdd68b6488c722ffbc6a831b04d41e4bdceec66c35ec78e1f658d4f05d638c"
    sha256 cellar: :any_skip_relocation, big_sur:       "72fc16f5b3d9fe50cba27c04f0c23340af53d79aaad702c4086b8c4944462254"
    sha256 cellar: :any_skip_relocation, catalina:      "c603d8e3331d5d77caa55a1bd899de1bdbfa63f2f8cd5576e451beaeabcf2980"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9284b70c777cc565a5bc926cd6254990d1b1b8f4014c900673388dab46696afb"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
