# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT85 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.12.tar.gz"
  sha256 "fdd07cad8e2ff42f0c9f095d84aeef11dab0fde7a008805f61883cbcb1b3f12b"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "60cd57665ce44832aefac77c0606c43feff7ba9d4ab7ccdb8907ffa9fa52b3cf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c8ba946dd2ea55b13a499ee19943840e6097af48176a5a81506a894035e753bc"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3d1489889d5456972d9dc66f86b27f0e0c8fff4866c44cb764ef5a7ad0ece038"
    sha256 cellar: :any_skip_relocation, ventura:       "9a01a855e888de6e520b05593ef9e0091e047522ed78100b73ed95f8eb7be70c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c7adfaa381731ea982ed785741048c01e6e27341c902989bb3477ff0ff6ec7da"
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
