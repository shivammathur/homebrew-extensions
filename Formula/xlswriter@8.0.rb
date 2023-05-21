# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cedb688bbde2daa35501a467cb9e7239ab7b269352eb87a95b20704a5dbf0707"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f0a47ab93141d25d4ba697bad3a131ef15229d23343da7e70d8b12ea1f5a38e7"
    sha256 cellar: :any_skip_relocation, ventura:        "757c87a8aab1e9d8e8274ee179e9bd93dc1124ba3cda8750c53761593fdccca6"
    sha256 cellar: :any_skip_relocation, monterey:       "31831bcfce4e1226821f004e5d2cb9e93723daf5044a9cf3dc2ee731c4a0b836"
    sha256 cellar: :any_skip_relocation, big_sur:        "e71bfbec681e4cd8fddb379025baa2e305788d889f89426c8ff77e2f7aab5df4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efb1619f4ccaaae3794f317c581079c3f57e8ef523cd8b0c01f84f95ae7a80f9"
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
