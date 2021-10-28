# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "424556069ea71960e8d3e89b7faabe5c0eaa336358220e67ccbf978a88fb376a"
    sha256 cellar: :any_skip_relocation, big_sur:       "7c5e62d97481325bef1c121ce29fda9d864bb4c50b8e582edc2f07f6323ebce3"
    sha256 cellar: :any_skip_relocation, catalina:      "63c73c6a2564a36e612e1ca1c705dfbeaf83c5d549bb433c40871570ac8d14b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9db7641d52146cb142214c67b7b06f866b4a4b4e22af145d6ed341bf6803482"
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
