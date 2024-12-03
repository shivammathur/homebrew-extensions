# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT80 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a4776938739921e7f5da85b4c66182a15c74f7f0e72d8490ae0b09242f1c7dcf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a1fa823868a523b64d7805b74302f3212d44ac478a69c0fcd1f3e8e45b74d0e6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a12b25024097d43075688f36feba2a36a5fafdb2f8ab958aff4f872e153da0d9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fa020ab99e36ebcc47ef997db5ce258f03d87dd26b0219ef8f5d0352cd7215dd"
    sha256 cellar: :any_skip_relocation, ventura:        "78eff8142065812c19c3a2a39a621ac8e1477c56d56b918df768973431e7e562"
    sha256 cellar: :any_skip_relocation, monterey:       "0e16b5b442cf02b02078f4be71fd6322600458861cf0180faffe84a413d02e3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ca82265943b7a868897352267704e167c961af1ee361bb8eb4de39360d698a8"
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
