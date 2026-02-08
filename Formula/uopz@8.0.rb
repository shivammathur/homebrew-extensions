# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT80 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a355532ef2f0655deddcc8b71e1de2d17c77c85a8b339667464f6931309b08db"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d67a55badf7c1926a005250f05b4690c6cd4b31be45bc3f306117a0cff9e6be5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1a0be019e1605a4f80192de143616df22b61d52f074c852476ea77abb67ba45b"
    sha256 cellar: :any_skip_relocation, sonoma:        "df6f6aaedb20dff85980de4d85cf40a293ba162521beec9242962a10cf798000"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a6a8d2567b231f4bc83a2199e1417d637c70f594b7019b48ca2bcce32a493e52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab1a2f9f7e448455eadd95b74413f88ade9ede291a6a24c1a95ac749aa7ccbc9"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
