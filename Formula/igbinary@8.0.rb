# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhp80Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c514f34422f2decb9289011352cf6a91d7a4914cb18695840eef8f08592977d4"
    sha256 cellar: :any_skip_relocation, big_sur:       "4b3f38787c6ad219e7bf944d138e1c1734159b9eef57038541b0064edf9a3ede"
    sha256 cellar: :any_skip_relocation, catalina:      "7ca400dcdcfcbf28884495257a77b44d62d73a100936aa4eebf385d2958fcea1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
