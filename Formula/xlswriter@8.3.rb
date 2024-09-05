# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b70192382f2e5b7f8ef0f9ff40f812241b425730a1223b72a255e6c64b547638"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d27086943a000d1f4548fc66324ac3bcf2e46f9c74aca02ee6b992d5b27729cb"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9790e5027b9fbcde2f449ced43491bed7d6655d6b65283c9df20853a33c6e234"
    sha256 cellar: :any_skip_relocation, ventura:        "b3a8f80b7a52c761e0649ca0396248a393de6ae6c7515233641f734b906e38ff"
    sha256 cellar: :any_skip_relocation, monterey:       "f61adf4b56e386a0d400d49f4ccde85b27f2f30ff530ff54883fb3c96aeb8599"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e97f275466b4cba62ed895add0ba1bc43752a3ee474977cadfab7b8a2d0277c"
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
