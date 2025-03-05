# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a5e160f7a2fd28d4fde65250fb96bfd4fae6abb796e6bba4ff1b61fcee0e1d87"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5544b4cb70fe3c6531a6e5c6e751aad6171cdd8e80acd08a81d32a472473bec6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "98cfa0a7f868aa087ee7aedd7cb22350aa9b0423bcccff07d6decb0ec16375a7"
    sha256 cellar: :any_skip_relocation, ventura:       "8b365b5258d75abf0adcc1e2590ea473121858e18da4b97d6b673dddc4d7d780"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7eb9b4127bddea5594d59dbbd4f3b5c2d1614450bce4719d67b5d9c93365ec19"
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
