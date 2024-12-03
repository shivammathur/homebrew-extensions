# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "10e3a281ab0cd718d798a433bb2570a90240a7afb4a7e61dd032473a49c48729"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "c4b322ed6e8e53e38bf125f28cc3b244c69e6dea4a864c37f64a1c592826e074"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e7f0e0866771c6213e508dabfa9e78984abd6b54bc38ef3cd782108a571b4538"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "549110272cf66a2d60038bde08bd5e2e45af3ef665ed24dfda236eafffb01ae2"
    sha256 cellar: :any_skip_relocation, ventura:        "291dc2355d69a7123c4fe90ee0507c00cde3e086180f98780f35f999c45b1ce3"
    sha256 cellar: :any_skip_relocation, monterey:       "aad53113b48a2e4fe705d9036c1c685b82d8b32ca43b71c72190ea775fdb1820"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4fc05d5df9fb0ff2ed2c1a8e29ce53d5ce84d479d5be391e041738d5c8d22268"
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
