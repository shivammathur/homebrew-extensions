# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3e5107ec327e0d9509176d152427b0b11d57c8ac8090242197c3da09595ac2c1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c78f24c7396d4a506ff2d82280d0059708af8676163822c35bc176f689021347"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ef6817ddd0c48e175dc1793640ff9380ba108bb58e77f4871f3ceb95ecef4572"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5cbc87242559fc6b11035d7f7d5420725635f8af3b3d00f9b50c5aa179e93b8b"
    sha256 cellar: :any_skip_relocation, ventura:        "c0b73c5616f8e374fcb23797b4356eb4c4051363b0e8600c8a0938ccd2a18cec"
    sha256 cellar: :any_skip_relocation, monterey:       "0ca1eca8480f81c69872df13bd05e379519c9bc9d53f7a696e19de8990f3aa85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4944f57e771fd817feb7cf2e2f3b44717ec9405770337a25fda829e3cd292ad"
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
