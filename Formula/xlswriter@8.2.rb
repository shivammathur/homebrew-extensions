# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "41595337d3a81cfd678eaae5208b4d24dba3346763e6b345587541b3ea0077c1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ce46509fb7f75d82c7380b4a3df7ec1ca3cfc0cf418d79a536cb8f2fd4185d52"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7b1d01e93053e90bdd3c11058a25b5d64448abc65e570e19dfe6112dfd6de3c9"
    sha256 cellar: :any_skip_relocation, ventura:       "c549e5d0d457f0f133c213e1a2f4ab679f323bcfbe82c5333eda62294080a6b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fac63cfd4d89bf6ab91c8f0f9fef1b3f51d27902ae7072185a8b56a508c7d050"
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
