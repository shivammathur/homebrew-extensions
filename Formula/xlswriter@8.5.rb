# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT85 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7ba3640fa1359daf6b695f7e3c03151219401f21b2899372b859bdc9d39e032b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fbfed119752a025cbd41ab4b4df9c7e66518b262c1ba0cf2cccc6ee5f2be7d9b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "36fefc301e2125db853f289c32597e8b48a1114531b1c440df2657f8da4d9cb7"
    sha256 cellar: :any_skip_relocation, ventura:       "4857ef93c31d4fa2d4189a99f80781f00b81d9696c1e38e853429666f4c7bff1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7520a907a46e90e7f100c7926cb5aeee756a1270f1bcf342b80662f231b0eca3"
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
