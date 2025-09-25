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
  revision 1
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d4985672c868f3780b835181d0adb85caf2cbc3532b81568b9f1383ab2e16a56"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0dec059f0627b01d0ffd82247db491e1c7ebf844020c95a483f6bf689ee3942b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b9d3966fe0077eaafb245b51bce31455936d8b835b0eba10e9a2f3fd5fe1d4c8"
    sha256 cellar: :any_skip_relocation, sonoma:        "475f66142dba78aacb926be90b149ff309a5b9e3ef95dc70acf032b8e1d095a7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a7b3183faa19b9109064ed73a32d753aa8177c34db8284880c89e14c3276678e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "69f20b727752e792d97fc43b63d6de101c353d877e141d347ccc2d69c1cc2df3"
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
