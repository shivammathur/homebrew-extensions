# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.6.tgz"
  sha256 "b05b58803ea4a45f51f8344e8b99b15aff6adb76e8ab4c0653b6bf188d3b315f"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "5824d3d0546520de53d71cca4d0a13eb005325098843c52198a5d37a95626958"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1cbed127537659deafe9ec86074df0f11ae5a022784c5454fbe18cd21c4d5691"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b72b23ccb0bdfc585b16fdcef1134fd624902665c15274fba1ec6431fd9437ce"
    sha256 cellar: :any_skip_relocation, ventura:        "adb67cc3e659af974b6ec9a580ff9306dcc0d151b056bdfd1d05c189f6642ba9"
    sha256 cellar: :any_skip_relocation, monterey:       "5923572d3a473f19ec25aba6d4123f6bfee9511025e5244a2f5ac534f2edaad2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "233a4ddb2e7365c9bc187ac800653a7681c470e761f63936018337345913fb17"
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
