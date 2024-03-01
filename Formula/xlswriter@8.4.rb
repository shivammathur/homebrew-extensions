# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6ab531b1ead57a13e408263b5691cbdb305ffc5fc4b82c10fd79fdcb75108fbd"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ea10cae73a33f19d768d0951eae45739526757cc533735d05dfa64bbb2d95737"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3ea9ed86b92caeb2403542a2cd0cd125b6184c116e892832ed7340cdaa87c84e"
    sha256 cellar: :any_skip_relocation, ventura:        "7b7b93a1f42447b10ab7abcb0b2aa10a4e39dc89cce88dc60678eef9e32a604c"
    sha256 cellar: :any_skip_relocation, monterey:       "ce15dd480f5389baa64e9ec6ab77ebca2b083a06f8dda18d9799ae126bbf5752"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8cea756d75973418d634764274330be8c561b695b6cdadbc037bc1d09ac36824"
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
