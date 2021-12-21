# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT74 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "83147b62160d224a8910d8677471340a61ef103cf7b4c7a8f65da3bec5469ba8"
    sha256 cellar: :any_skip_relocation, big_sur:       "0f3ed1c83a48de680127e42f68af517316a76139ea055b08a6093f3a4a2e7de7"
    sha256 cellar: :any_skip_relocation, catalina:      "fe7820bbad6681c90104578581a2b3254ce69807d36ecdbc716e7a0a181e3cff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "321ccbbb6c918e25a1a0458469ea3ea6f726cc65aff00972a81ebc3986d56056"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
