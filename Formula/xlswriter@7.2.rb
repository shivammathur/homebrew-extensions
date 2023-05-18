# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ceb41f6eb2dee02ec60c0b63a2ee39cf02be240a6a51fd0443e5346f49192bb9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3f51085855e26e5fbfb043dc7b72d3c339a3801d0b90f72c42192712c7811455"
    sha256 cellar: :any_skip_relocation, ventura:        "5fabe966f5cfd4b33e8ee465141c9e2dd792a967e41c250945a925399cbf1d1f"
    sha256 cellar: :any_skip_relocation, monterey:       "f6c85573ed438a8fa8824b75d719c2b8f90a42aa359e07a89b8958db1140e318"
    sha256 cellar: :any_skip_relocation, big_sur:        "94e476dd94217454c5b5c0a2272a9a1e1c9dd4c352239b65a40957d3182416dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "876b16f20816910ccbb2cc3b4232ed3421b238e875978cb5433aacabf30608ad"
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
