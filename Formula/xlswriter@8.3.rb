# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1753d0ecb9fe576eed76cc39c9e2da3ac8217d986a50a91de42734da84219ae5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cdc3547377a85e0e145974a8c045c08ac82781aae035065d23339ba77fca4749"
    sha256 cellar: :any_skip_relocation, ventura:        "257298b1706bfb154a50bc9cdb5bc544e4724b888580dd72a0fbe4c306c2f212"
    sha256 cellar: :any_skip_relocation, monterey:       "89197f904e5511daff1898e23686a7a573c78cffedfdbc45e9a266368b11ac53"
    sha256 cellar: :any_skip_relocation, big_sur:        "1c2f0925a05940cdb25e4bbf65756f3db68440f521d758e211daabd810db6291"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "03214e97c12eb3dcd043860cb8817080b2b770a339666391440b77528229514a"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
