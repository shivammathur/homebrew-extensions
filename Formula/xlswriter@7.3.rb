# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "97f9f04bb0dd6817650022fb19d22a87c0f860784be7d2d1f3e1d3a2e83d7d25"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "23c82d5893dfa8cf4b65d6cee8dbc7fd45a52b35b3875b1fc973320b67629de4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d8cfa9e9e7269693f296f261a5d5787e50a861b27dc76b2cb0d1dd766cd14dc1"
    sha256 cellar: :any_skip_relocation, sonoma:        "c3a1c342ba95cb3f04e6a1c5611af369a491be95362ee3c1cfc2be9cbf040f97"
    sha256 cellar: :any_skip_relocation, ventura:       "728edb41a18e2216afef4e354fbb22b6f164059f94f5c0c952740a170829b797"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8a2573a7c384d887095e9d219b36abf0387071441e3a86f8442b5c34a0609aa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "95dc4606b3f71a44bc37a92bb58d972879aa4fdd6a7087c6d69fad97361f200d"
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
