# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "259deab60438674313caa6978a7d663fd5c3c2ea5e5aad3dccb1c302bbda25d0"
    sha256 cellar: :any_skip_relocation, big_sur:       "e3f0ece73061af731be7dc4401f73174304d3adb189ad175134d166d2fc640a3"
    sha256 cellar: :any_skip_relocation, catalina:      "ab2a2a0012728be7c6996fe83eeb1847a9d80be72d660733a033b26bcfb333b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f7b86b0d1330e46a85664697b4303b133ee828379a29c82b908b2aafc9326f7b"
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
