# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f92fccfd495f47567e3e192984c07d54dd14bc04c340a73ca72ae9d859b25920"
    sha256 cellar: :any_skip_relocation, big_sur:       "9ed4cb52d4f47e59c8fc2524878ba4e4dc042cc08231315fa78f7d70f57605ae"
    sha256 cellar: :any_skip_relocation, catalina:      "8774e31f1afa3ec11593577a4a7a7eb86f00ff1d8b3e1ae41d7a38942e43a23d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee429dda4ac27f2a57060f246628cee11adfa13ee3f58d2ebab8e799429b8e60"
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
