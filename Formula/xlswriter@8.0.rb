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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "251c1e2bd74faaed6a558c8002c31acde52a3e5bfe544bcfb1aef49acbeb1cf4"
    sha256 cellar: :any_skip_relocation, big_sur:       "59bbbb5e0a70b0cd155c3d2b1f27ba0d3d5e7aa08a00ca7511124e70eab52e9d"
    sha256 cellar: :any_skip_relocation, catalina:      "fcdbab9184d17b5991652a3d6139064812261f3ea0a441f67d61bf6f79245aaf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "38b8a1e608f8db5a33087375535afec59229eb1fd125b722771731a13d8de9fb"
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
