# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.2.tgz"
  sha256 "fc363ef816c8efc46f9b5f6c86a7ab4469a803659b8d6b46421d143654361ea0"
  head "https://github.com/viest/php-ext-xlswriter.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0208f71ff4f60ee1eb594b352950ff4685aa2875f42591ba092d69b851809f5f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c2154d4ae566c65d1f24e51873e6aeb129e759a9dd75bf7177934cb26c13a797"
    sha256 cellar: :any_skip_relocation, monterey:       "daa44486004a2e0965fc61e77b127645d8f64f1996f427998e38520c07e6210c"
    sha256 cellar: :any_skip_relocation, big_sur:        "096271d68e57174663189fd0fa6833c21304bf2b48e6f3bdc5989a5a7940a1e4"
    sha256 cellar: :any_skip_relocation, catalina:       "bf73a427cfabe40a03f2a14cd34c6d3070a119655664f650d1fb6aa51181045a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53ce9d2272b52001536a2b8a01d17451bf263f7154841787b15ca6aa92376191"
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
