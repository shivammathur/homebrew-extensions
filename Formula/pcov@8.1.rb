# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0a2e077ed14a94cbc978376ab38ec61a8636828b66243c186d28ea65b68bb273"
    sha256 cellar: :any_skip_relocation, big_sur:       "929027d96e3c2770734c7d77a5bda23809ebacff72d59a963cfd914e9a6ef984"
    sha256 cellar: :any_skip_relocation, catalina:      "e922f656be25e18711c9e2714b1c1480fb316b043157ec333f5e14db5c0df521"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "59e404c635b642b3f9a930a1e143ebca8cfa5b33f5a9cd4c3d3b30097e2ea73b"
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
