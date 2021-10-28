# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "171220fa7ed5dd7c4fe195c50929fe53576e0d4c6ca1e4c289a5976fb322a075"
    sha256 cellar: :any_skip_relocation, big_sur:       "95b30044bedc1c01e0b89440217a9163541da88273fa36c8ca1e39337b5c8f6e"
    sha256 cellar: :any_skip_relocation, catalina:      "ef18291ea7c05e4370700496e56e001ed5790abbd6e6fc0da24cab9bb960ff74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae4e231a936eae5e7ddabde0d2196d576b20fe8e176f4428ee23c9dfd6dd3dbc"
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
