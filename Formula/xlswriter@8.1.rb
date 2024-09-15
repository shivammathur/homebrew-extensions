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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4bcb1f83b49aef72e3a2b1e7ba2f79f8751a6c2c0f55c7e928124ae42b28f63a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a56ceb11dde8ef2fed5742688173c6460a7b5a1fa121d8bafab4a5ae4d41dfc8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7766725b1edf681b335600c4323d23ba40cf0b025ddf54ae6564fa6434e2dc8f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "774c9670caf3f9eb5b4c0c9d0a223777a9b43714c8ba89393fb39518940882f3"
    sha256 cellar: :any_skip_relocation, ventura:        "c9f9643b5bdd9c2ae5c77d3c45d8a98c6e858fe45267b59c8b6736150f1885d7"
    sha256 cellar: :any_skip_relocation, monterey:       "91ceda97da376c0073c0e5fd6e87172e7a82298e396fc16ebf40260c7255cf03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "00c05d23d144f004208e4055550c9ce23c161879619bf05bc5dd0a6232747d12"
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
