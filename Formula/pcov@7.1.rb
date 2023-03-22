# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/swoole/swoole-src/archive/v5.0.2.tar.gz"
  sha256 "14d442d5e945fe67a3e912d332175b2386a50c38a674c4559d2d0211db23362e"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9109cc64a367c4f84c80ecc07c29529e80baf64bccbccc21988a45436d1c9554"
    sha256 cellar: :any_skip_relocation, big_sur:       "4d5b61e736703094cf752725173600f518761ee00567a7d3108daf0c6afe0f4c"
    sha256 cellar: :any_skip_relocation, catalina:      "51899184179d8466fcad7cb6a7ca7c04445ad18397a7e9c235572782c39b4dfb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f819e206180c2a685e557e7bb03eacd3cae8470fba4d26db48f3775cd60bacf1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
