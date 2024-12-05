# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT80 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "496ed37c0b8bcf2b7b6d4b010642757a2d73342e0e2d00120e3a92e136d47c51"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3c1377e0724e05701a10eb7602dd9438e5dcaff80048067d0e218c5d5ffcfa40"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c0bbaf0001d0b9fe5d5f47dcc04a445ee9336692acea849579234f64c18320da"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8dfdd68b6488c722ffbc6a831b04d41e4bdceec66c35ec78e1f658d4f05d638c"
    sha256 cellar: :any_skip_relocation, ventura:        "053fb041db1bbba415f6f58164c496a9f9b16d679805c4403b2b8f9c4ffb7b20"
    sha256 cellar: :any_skip_relocation, big_sur:        "72fc16f5b3d9fe50cba27c04f0c23340af53d79aaad702c4086b8c4944462254"
    sha256 cellar: :any_skip_relocation, catalina:       "c603d8e3331d5d77caa55a1bd899de1bdbfa63f2f8cd5576e451beaeabcf2980"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9284b70c777cc565a5bc926cd6254990d1b1b8f4014c900673388dab46696afb"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
