# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "38c6b18bac98d714f39d87c5eb9c1c38155556dc165dda1bf6181a0dbf22ecff"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "de9b6450d79fc99a0b24fcd8ac6d138db900bd33a297ed948f27a83635eb843b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "84281ccb02b893a363512403e8a80944aaf38c88ec378ce5c0f42449e0465d2e"
    sha256 cellar: :any_skip_relocation, sonoma:        "346f0d2c7f1d804873b62c4f97084653601d1c8a0d5ea2f498df903d25865af5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8e87eb59502db8e43e0618d55915fab26a761765557fdd1bfed7f7469ed2ec57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9eb8c228a3f9032ad4a496e683a381946445d40156f9f386e67c5f69c4bba93"
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
