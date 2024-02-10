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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0f81cad39317b43d4cffeae3b710cf77781ccc96a8fa7f1bd9a6262852b0ecae"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "40ce26d10e9b426bd45bc455d3c0fcf599d473eb927488ce5599d353d430b463"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2216c95b093d5f10efb28558ebd005c3563e871f4f6038d1e4faafc199667d46"
    sha256 cellar: :any_skip_relocation, ventura:        "5421f46fa6f9c4518629d3567b577fd8ca214f20b9f9917f2ae7cc6716b61dbb"
    sha256 cellar: :any_skip_relocation, monterey:       "9e11cfb14d13bb64de2e9adb087a2638fac0ed9e546f0f6afa015a4ac99cdb6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b69df4391c052c9c7398b88a6f9cc9d06306336b5d649b9bb57e5b44c4a3a193"
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
