# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT84 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "73296412f530e02cc07b467b0e43dc0f14b053fe6f1d3cb48ff5ca022ebf3084"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8d150b17e137e5b53cdf17fd898e1bef4684ad7602effabd6f6713658f53eb50"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d924e468f2af1cdb6e2157c0ba34f63a01e44fb0c027ad5b0692e8528b0967af"
    sha256 cellar: :any_skip_relocation, ventura:       "59010d1cb15b96c54e9a78888453e8799e0db84cf5caf83f186939e43aa2a1cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "61223d753da00b8cd0f85f1b0f65021014af0b707625409743efc7b4b2c70333"
  end

  def install
    patch_spl_symbols
    safe_phpize
    inreplace "pcov.c", "0, 0, 0, 0", "0, 0, 0"
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
