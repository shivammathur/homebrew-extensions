# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT83 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git", branch: "develop"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "004778924bd3c54b48fadc358626c6dd51ab72d0678eb648265ac6a16b3207cb"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ecb3d3df1845b8c9b01c6e645e11a448ba870659da711478adabcb121efe0165"
    sha256 cellar: :any_skip_relocation, ventura:        "1b0288d2aa96195b8d3b8b744ca01a22a29fdf9184bfec9a8814040b6b1cc944"
    sha256 cellar: :any_skip_relocation, monterey:       "79dffd5f96ca10e3fd5129ca08835289bd0d184dabbd29a9e61a0d9fe0de25bd"
    sha256 cellar: :any_skip_relocation, big_sur:        "4df8d134a706e345d5722da4ea4de24b2fda30cc84a5dcd60d1d3dba3b4a1c02"
    sha256 cellar: :any_skip_relocation, catalina:       "93789ac3d50b122964d47548092f05c7f15b680411f0406e7e1bee5a2609fb81"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9a10e3d90082b0bd5e5401ac6df34599d61781c03921b36820db033dfd754517"
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
