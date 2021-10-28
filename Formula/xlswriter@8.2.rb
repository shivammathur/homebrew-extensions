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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "437c0e856516cee130b4ab4e916c1c5157d123195ef413cfa4c3aff2dd1f9f6d"
    sha256 cellar: :any_skip_relocation, big_sur:       "1613e7644d0c48dcaa7a56ae35495bc8a0085aaf5526c6bc960096d7bf6514a1"
    sha256 cellar: :any_skip_relocation, catalina:      "a47756c937cdabea3f38827b624b1f8acd1ac834e2ceb5ad6625bb79ec832d48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e47bd54d381334cc539c417f71eb344f3cba3a2ddf1b137ea150c412fbc9cdda"
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
