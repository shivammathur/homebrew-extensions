# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0c30e24dd8e1657f60fa68fc72d327695583502496b1528427870d156cac884d"
    sha256 cellar: :any_skip_relocation, big_sur:       "02c640cb49777347e2193e4a114e2a96849b49bc369fc40a0ec89270f0244a24"
    sha256 cellar: :any_skip_relocation, catalina:      "50e0c0adc4d028d4ef58c71f8cc78ce9593c39a02805ce1249abcc425d57747a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d719bd31afb356958d40054c4e0e28ea6261a10b59fb20f7613702178b1c79c1"
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
