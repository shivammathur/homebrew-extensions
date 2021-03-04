# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "735f27a174aad3ba85a6761a91bd9792fd367c93c93bb2e40d2fd10b57835536"
    sha256 cellar: :any_skip_relocation, big_sur:       "a0718aed6809a565f4811d76fb25b1e136f701b7d0139371194c7913790603dd"
    sha256 cellar: :any_skip_relocation, catalina:      "5bcdbdf34778e709ed34402f9c1cdf511b897afe30cf4a3ba0d8c42eff7abdce"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
