# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f3f7443d7f2fb1a1e3c005251fddfdac40218fb02464057240fcc388eb6a0493"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c4f9fd3b3bce45ad5dc78b438fd4dad3c3d9ad1895dcec1ffb0f7a9c8a625bd2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "354b0a9a749708ce19a466b70fcc6885533ffbfbddf3004ce53ee4c6de72d373"
    sha256 cellar: :any_skip_relocation, ventura:        "b518e07075c345f37f16e18d629739b8bd949c55a6b8633d1e4ec0dc446b8ae1"
    sha256 cellar: :any_skip_relocation, monterey:       "2240102acd3f7b404bc1ce36f08162d48f2d6fa7712ee9d3502c6abfb705a594"
    sha256 cellar: :any_skip_relocation, big_sur:        "e87cc69916f5ecd8e85ff46a4de3a072cfd9dcef4025603bd55359c12518f37e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7932962237facd22fedef2f76ce00978ced09db57a98c63f2f96b0c9315b11d"
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
