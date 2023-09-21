# typed: false
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5bba10eb108579af4f845f0685dd9529fcbc089a3a584253a4200700fe909b46"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b8847beb919063e33169b424000b7183f13787e50ecbd7266c82341fdb501bd2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bdfe7d393b612ee5c8a39d66a1055b8ab7a2d347a2c5c5911f695fe3acb35df4"
    sha256 cellar: :any_skip_relocation, ventura:        "9142314ea4830b1433d7006bff4e69e3c4c912566cd033d87a50d25685c0c841"
    sha256 cellar: :any_skip_relocation, monterey:       "fbcd7cde5eea93eaf5d082c07107e168c978ab0019672d7f5ae1a4150f697bd9"
    sha256 cellar: :any_skip_relocation, big_sur:        "d3d7b371b294476b14246c8698310ea1fb91294d258e464e671ade79c8e8824d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5fddfe53f064cae705b8ecf40df4c177750f20446179813bee431598d44cf8a3"
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
