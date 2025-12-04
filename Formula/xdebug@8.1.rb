# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT81 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.0.tar.gz"
  sha256 "b10d27bc09f242004474f4cdb3736a27b0dae3f41a9bc92259493fc019f97d10"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "351ba3b6355f2f86bdfaa93e4675e286ec43391d017638490f0f944486e9664b"
    sha256                               arm64_sequoia: "2a8961f3c25eec0ec1e89b1445743ac019c2aa259fd22092c652b2fc548ecb98"
    sha256                               arm64_sonoma:  "c1491bf280109acf6325aa18a734fecac6fc8c13eb78596ebd85ad610ed94a81"
    sha256 cellar: :any_skip_relocation, sonoma:        "6442551d46a7f982f025bda156fd5892c67faf1e9ea2a6150c60ce9f87d279ca"
    sha256                               arm64_linux:   "41088ff9d4ccffcdf94e321cbda7ce8945f89f8d4ceb40da1525c821d11ae9c5"
    sha256                               x86_64_linux:  "88563184f8468fd62f75c1d2117ab11c68564066a2c33d0832b8e33f5f82b510"
  end

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
