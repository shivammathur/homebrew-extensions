# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.1.tgz"
  sha256 "101e3d244e8b4fff7391f5a2f230d4d94f01bb6a1f42cfd9539599df0f3957c8"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5c6e644315dc6725c0a65ace2072984c2f12ee0951ad45c27b0ac1a0e6dadd5a"
    sha256 cellar: :any_skip_relocation, big_sur:       "8d244f98e8b994f4879975cdaa6056058a5c6f8df1c193b655cbef7fd8136da0"
    sha256 cellar: :any_skip_relocation, catalina:      "e3c538440b207e5efe71f36fc000a171a8437f27891e7dc10af212b34654b8ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "69f0eb0cbe42956b0eb18d3ab99657dea8257db8f0be14984cb9f0a0b4b2db7f"
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
