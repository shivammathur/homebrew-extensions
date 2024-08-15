# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d2904ed12df7c7be487c452ff53ba88fca270b9293eec7ac381ee8c0a5f8c85d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3ad81cdb21a04635acf310b9cba6230ab7d0e548c318320f8534fbe20c73cd74"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "213202f4cced05422d31591901e3ba0c4c478750c6a2ab0e8ee6b8481afd697e"
    sha256 cellar: :any_skip_relocation, ventura:        "35c343c2e838f9717784fecf63373b1647dd93d46ad5d753b2c734072c2b87c4"
    sha256 cellar: :any_skip_relocation, monterey:       "36417bf7537029fdcbbd5e80ed23763930acdf02eb4c5434a60674d598270f13"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f03e22bb571a678ac29e39633b06ea1fb8f3f8d31a315404e9ebf854097284dd"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
