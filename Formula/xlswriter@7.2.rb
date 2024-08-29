# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a0e1d0b42026fef72c7ead09975de32ef22af2446e71a5acbd921abda52d8422"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "35cdbc05d874f50e5390bbf72970f8a4e0911bfbe3882905c253a4a3cf22f450"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "aed9c1fe5fbef792aa2a9dbaf33226a7df22ad6d0db45ec8424bf143634ed9aa"
    sha256 cellar: :any_skip_relocation, ventura:        "9ccf642ea7aedb0dbf4980db5104c45dfde586966bacc9f1dadfa8f261c1303d"
    sha256 cellar: :any_skip_relocation, monterey:       "34e36ec044be3fdb793eb7e401a9cdc5ffd1a598722219e7e70b566290d3a9f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ca8d1b2cd316a40dcba9a802164c50632f67d84e6e3e0cc86883fcb0f50fd067"
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
