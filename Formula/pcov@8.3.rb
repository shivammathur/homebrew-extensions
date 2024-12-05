# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT83 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "65edca107e14b35bd900f8372b6c1ee884ff23588ac91460952024555b5e4475"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "541c9f0b10ead86c9ac10eff6fcc63f207797204d71195284d592ef7b4d134c3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3dd17a0523c34d80c47a6d904b0cd238070679b8f61dbe845ee90fadbcf59b99"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "65c8ab8c79caab42ca413dda0bdb83637bee2469febb8a9287c42b90d9aa3581"
    sha256 cellar: :any_skip_relocation, ventura:        "9ede0b4c67aec689e0b18ad86cc227ae51b35fdbcf382d86082da4ac4d42ce37"
    sha256 cellar: :any_skip_relocation, monterey:       "6d04fd92eb024cad78ed3d77dc3f6a6a6a703ce41c834ff2e4d61709ffbbabc6"
    sha256 cellar: :any_skip_relocation, big_sur:        "d0e54de5dcd1841bcdf3f4085d0e86ac40c6ebd3bbd573056ee678191734a173"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9cdb70e1ed44425fc235c7a57978e26d5216197ce6aa773d0fcaa4a8ffc6257c"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
