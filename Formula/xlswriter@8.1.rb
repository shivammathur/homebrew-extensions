# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "fc32eea581bdc6da260705bba77c3f1b13e1aebbae87490fa4c6cb3bcc6a96be"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "53284697a3d28d07a7ded53aebf80a4ebc717b617f70115a8e050d1bb6f84845"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1e07d8f5bcbd3d54857fc6affa204c5fe8118c8903fb439a6bff8662b68fefa4"
    sha256 cellar: :any_skip_relocation, ventura:        "b03c8dfcab9e10605848769c7310a7d31e8f2c2fbc7e1f739a421fa8c57c14f3"
    sha256 cellar: :any_skip_relocation, monterey:       "3f833ae165729f9d81e64999ea9957c01c52eb7b80e721a80215e2c1eea240c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9dc5ed982661da798ea3abf5456dd515d7dd403be608c95906fc06b91f4e2894"
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
