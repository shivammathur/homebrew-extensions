# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT74 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "e443ac39aa3e115456fc65d90d4cc15112c155ceb79139f0387ff39e804cdb46"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "94c416b913f6b44955d051e3a02544b386b54cc67251b2bba66efd527e20fb46"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3b632910742a005f87f17255b86187f03bc4f2b8bdca10c52a3bb0f8bf5a9d2f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "83147b62160d224a8910d8677471340a61ef103cf7b4c7a8f65da3bec5469ba8"
    sha256 cellar: :any_skip_relocation, ventura:        "b7793e75b4b76eafdbbb7aafee28e6a93983a6deb601dc320f6985e5c7848cfc"
    sha256 cellar: :any_skip_relocation, big_sur:        "0f3ed1c83a48de680127e42f68af517316a76139ea055b08a6093f3a4a2e7de7"
    sha256 cellar: :any_skip_relocation, catalina:       "fe7820bbad6681c90104578581a2b3254ce69807d36ecdbc716e7a0a181e3cff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "321ccbbb6c918e25a1a0458469ea3ea6f726cc65aff00972a81ebc3986d56056"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
