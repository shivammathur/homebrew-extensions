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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ef1443c025eb5eec871f1bd505fd778b682baa57076e8e592490d59973a69590"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "45120fe494a4433a4ccacb56cdc9ebe24da20d02080dfa124a9d754df5df883c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "18678cad1660a7ebf39524fe39b104052364fb91f1fa0ede6fa7fbfd5483c731"
    sha256 cellar: :any_skip_relocation, ventura:       "30a8ff71ba67598c662821f3b7448307c86488b526a348e661fdb1c65d7ba539"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eb3a633982ccd0c47e933d7c9b377f54c2b18801ad1330a3c11d53cc216c9cec"
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
