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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "7b907b5240f0da4e68a9211a013e75d040643fdfac83b426c06d3e8b49cdeb9a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b739a4b5fb1863e3071a56c42236fd75530cbf4b53ba47b010a2e5295f7ec485"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "255b25c7b5db077f036dcedc0ac9f4b6521d5621a305129229ecf7121f624d66"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "23b079004b2c57aa046f51403df0337f1d10f35618d5f5d03a07673bf4f6660b"
    sha256 cellar: :any_skip_relocation, ventura:        "603126a188c374bf3b6039d15d2e3e228f9bf32dbb3e5776d85063909dda4f32"
    sha256 cellar: :any_skip_relocation, monterey:       "deff5fc0a277901b91422226c226d64e7095e43fc02e414340abaf50118d78f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a15a7d9eba699fd607a96c533482b029e4c64d280b174ebf7b088fa0b922d859"
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
