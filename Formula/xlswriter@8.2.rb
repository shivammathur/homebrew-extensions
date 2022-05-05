# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "40607ed8b48d59db7dff7ef73c505abf623a2c9b3d78951dfd52c7738e8f58ed"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "46ad3b49efaa664ba9b7beb720bf1c4e984ab5225d9dda0e0f6073d668f107e0"
    sha256 cellar: :any_skip_relocation, monterey:       "cbbfb2a5c9dfb8d3a8a2b0f7ca9963417d2f95323884c21819622b0647b52339"
    sha256 cellar: :any_skip_relocation, big_sur:        "c7302c946e3b9aff9c1d9e9c74d7129b37658d9308c0cd9859d5227f485d38fd"
    sha256 cellar: :any_skip_relocation, catalina:       "af5dfe68026a4b804bf23c664ada25f8aba74957fec5594d0176b9317c6dde4e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f683dc72cc366bf279d8dc50cfe63f310434f96316fc81dabdadb5ffff5f4dc0"
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
