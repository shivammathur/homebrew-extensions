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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "690374c7eb69bca5eec7acae6e8769673750e8b11c886fc163cc863198c77679"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "42c01fdae14476156518fddc3a3d8b686354960784baaae9fc0606e820fea8f0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e851ea2401cb8d3c6f8afa4af4ecb88b003a33c0feb84fa0d966e4589c83cde9"
    sha256 cellar: :any_skip_relocation, sonoma:        "ac35de9599ee9b88f5822cb789fb7ccbbbfac30be82af9f8059e6b94987582e7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "190a3a3f6b28879c2179a6ebc30d47a6b9fad0672c27c84212610e03c800e627"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2dfafd469ad4a97d7849d7251dca48c34987c8cf40a88748ad6a724b81cc0175"
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
