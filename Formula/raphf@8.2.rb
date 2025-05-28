# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "30fd6148b4494328678d1d5bd654b6ef57c8454e0c75c6b1458f54bf6c5dec26"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8c2b507dc2c4f5de76896016f5aec94569586901c539fa8fb4ec380876e542e9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "804f691445be6af6f2b09695053d3ba3dd93f6229f6ca30a1487fe289ea91209"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b065adf548a25db8f615a6741298802dd549fac6413796085c28a37df9b6a50b"
    sha256 cellar: :any_skip_relocation, ventura:        "98e89e0ad8b4a88a44a80dc028153a4a7b196fadbe5a862a5269b70c743bcdbb"
    sha256 cellar: :any_skip_relocation, monterey:       "d37b53f24a1304edb8f22d859b607f4dffcd0fed06e406b43e1eaaa2c4ec5da4"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "5e5e6ee9fd7d9edc06ba1f84d44af78c7593d6c5bfe5c2a87c7b7a3229f0b483"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1fbc35c6bdbc6ac9cd45636e9247a9d897431b41c90732d4e96de545a189f2f7"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
