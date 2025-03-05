# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "231b98ccf835f1536cb0d1a3c90fcd30fd27f24e8ccc8745e5a2c89561e845e3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7c458635feba96f80993fe2ac2bc50c3c384af067dcc4f44f04788fdb8a76605"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1a9e21b7e4ba2982e95f1c4d9caa42bf8d082c436c3e50b8140dcf7ab0cdd451"
    sha256 cellar: :any_skip_relocation, ventura:       "b6ef0a209ffaac7e8028c421b047e3bba34f9bc8a620e174daa765cb75356717"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "126a7036cedf979158be0dca62d48a3fe9a78f71745f629aaedaa2c5162aa6de"
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
