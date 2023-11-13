# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.5.tgz"
  sha256 "4b8c8aacf48737c0d741a2401f4c495318ca18879e9bfcef5f698946ef28c671"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d06ff8aa14d6b9b7dd38ff3c0aba7b03e317662a6380dba3dbb0178632197ee9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c811f2f2390172bc68f4aad189e5f5da19202bea9139cd3b55c129b221aec0dd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "497e44a441457d377df8ac9861ff1703438647432919f4e1104757f6c248da4e"
    sha256 cellar: :any_skip_relocation, ventura:        "5a6024be4e9eba46081bddce1b1890fcebbce8803add51b105c7f1a841af4fde"
    sha256 cellar: :any_skip_relocation, monterey:       "c6bc56b77693f817c58fcf32a5c59eea27ac6f4cc5c53260c4ed14b51c005a7b"
    sha256 cellar: :any_skip_relocation, big_sur:        "0f53c696434597213c554bc9e2d8788bc5fd3960fd7d9589a261e401a39b5352"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f7e7dd91b38746b88a3380db206c528f52f1c1ca9fc03df75fb9730eecca22a6"
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
