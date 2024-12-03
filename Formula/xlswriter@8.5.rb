# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT85 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8cbea320883da23c69e52d505c4e4ddefa69d7ab22deef5a8901e331f233733c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "94f6784b989e5d6d7fbe0b62567fd67011de086ab952c691b74599e136b847b1"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b0a3ccc4ac99ba99649b8ca1fee1d8ac75c9374c6857be3b78ee07195e46fbcd"
    sha256 cellar: :any_skip_relocation, ventura:       "fe9d21b7c210f3acb41f3c0e5d6bb397c4acf26c26994b9c92cd95b08cd0e16c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79a4b4a9911d0428b787cab85e21dfa475da511a0162121a954c11172cfb64ef"
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
