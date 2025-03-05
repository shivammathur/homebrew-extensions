# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT72 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b97b26361dd47211a8fc56a91920079dd1b9c730fb2489c2721dc44797d8b287"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "622485613c9cceb548325dbf11b10eec14586ac7a2ccb1cc1060859a9e361360"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ffd945f6855bd7bf02e647a25d6b949d27f6240043ec68a9d7f2dfae62913f40"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "183f5b4912aaf8f36252e25ba8e188b8a15dc7f4721adca24145cddf67392482"
    sha256 cellar: :any_skip_relocation, ventura:        "6bd8ef30efaf3f5b653428792b5afbf6af08ae745a59c4e40f964252061f4f03"
    sha256 cellar: :any_skip_relocation, monterey:       "fcc8985843521fe930564d586f3faebd241ec706b0c69785c12f11ea90303064"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f428440e406d124d18e00c3ef63f547faf37d410192745aacf4ff5722d0b1efc"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
