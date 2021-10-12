# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.0.tgz"
  sha256 "05698726e123e4c339ccaaab80f0a81705b9bc9c21377f0951c9ad51df4718c6"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "466e11cc5baac14a89f89d3460782c51a053625b0701dea2262c71da72b219be"
    sha256 cellar: :any_skip_relocation, big_sur:       "2e521122f5b468ba766a0b4de8977f209f77b5dd9a7e3daae667964246e8e7ff"
    sha256 cellar: :any_skip_relocation, catalina:      "046f156a07372298b2c93e65e89c50ccaec1edd7bf1d746fadd7425771ad6d85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0ac2a090573eb5f3fb332386d245b668a4d8b0e81c4726a7dfd2c0b5e29e1b58"
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
