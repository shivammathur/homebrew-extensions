# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT82 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f96f48c242ad3a0e7dfb995ab829619da01208d072b5b9df92b726e35feb8131"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ab3fbe378ff33ef757fa6404f59be1f079b84ba6b7dde8f611437d15f52bbb9f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "129a879964b906b08e4ac66707969df30f8a9ea6b285fc12eb1d199a3db2c423"
    sha256 cellar: :any_skip_relocation, sonoma:        "8b5cc7db10027e10fc672aab5707842a09e240148e6da1c93fefa583df5a52ad"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a96d7454ae3a7a5880022b1932c03088b036973447e575d754ea8c71fba31262"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c7c5260c8686c6781beb77ebb16d499cf4268c41b77c9d3ca93f4e14af66d12"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
