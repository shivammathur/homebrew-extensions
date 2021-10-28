# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d7defbf23ee8f88f198bf733685a367267c4cd18805344294181a75ba7027158"
    sha256 cellar: :any_skip_relocation, big_sur:       "f71c9225fea1864124d69b120d509629d18cd5fae2cab5612ba019b45e464918"
    sha256 cellar: :any_skip_relocation, catalina:      "4321ff405a2c34a1b26ff779b4a2852e452e65c1508f6d4ddd43aa5715520e15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "226a5dbfebd38517533a158f4b4d5f873dc3d83c1e5f2c6152af7ffec68e2fc2"
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
