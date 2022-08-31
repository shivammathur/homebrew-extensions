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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3c9738d8505332a52dd1ee757b906eed798ec31beab8ea518a701bac940d8c8f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "83471048594f0d0f830645ace42b8a825a2f87a87c5bbec2c37789027bcea88d"
    sha256 cellar: :any_skip_relocation, monterey:       "467d68c81dc7f4ebe954ee105074639c963af92e0ea9219f90786668d841edcb"
    sha256 cellar: :any_skip_relocation, big_sur:        "37cfcc06655a02f8769046b977dfce5b0f53aad54b1669d25ed9e2eb639efa51"
    sha256 cellar: :any_skip_relocation, catalina:       "83b7fbfe19c6ca266465a42d6081374574aa8ac383c27c3adb6170acd6313a90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ddf62fd036b1492b1f7899d46b9ee83dbfcf49214c8a1e6e431ca8404fc3c60a"
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
