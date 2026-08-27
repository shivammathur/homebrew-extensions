# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.3.tgz"
  sha256 "629c33700b591b633c13e851ffae8124758df658154e3bed828c828250508e00"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8bbc10b5d94c3b8f372d76eb1e93fab48a544dd4bb4c0eb33dcfe2802d7b9b1f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6aa4c80fff94bc2d13321d7be3bbbd41e7985b0a4a3a2e17add8dda674fe386d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d3203a5a779e94ee51295897152e2da28caafe0db05c5216fe558f4145b13f38"
    sha256 cellar: :any_skip_relocation, sonoma:        "5705bfdc84fc8c707e8e221d3393d2344f324f50bf95dc28f0b7d1f68aba5660"
    sha256 cellar: :any,                 arm64_linux:   "579e71bea455ae2e71dd926608fed92f33af171a6aa817c2fc54dbf021e55ddd"
    sha256 cellar: :any,                 x86_64_linux:  "f77e9d58a0842a335fd904615de990c50b77c32b9ea5572cde9e32bece926f33"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
