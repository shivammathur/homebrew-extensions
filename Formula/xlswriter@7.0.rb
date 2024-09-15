# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ebecadb080ffbb16f32c0aad4f34e2a93f3e7f2d1cf858e388b2081704cb9f04"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4b1df26cd56d65e6ea04f7d4ad68c7ba2305f6e4e6a35542534a7e523537efd1"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c0ae1227c50bcf07cf7ba1cde70d17550b71755640066f61b8c4f6e77d8d570b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "6573836cc68aa97515b20e95a496855ae8e7151e5beac3d7504831ecfde79e3e"
    sha256 cellar: :any_skip_relocation, ventura:        "e0e7e28af5055114ba0143a8c591fd5912fd0b508e95e52c23013369f19384b0"
    sha256 cellar: :any_skip_relocation, monterey:       "e02af35f8275698c20e79f8ded55a1d7e600549edf775eeffce1c8859e4546e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cf73790178292fc03ef2e521ddd63eb371cd47526f519d85daddccf3126d4a7e"
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
