# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "5ad4cceb48ee434857855efd3aa08aa6531f950a3ca5c15c207a7ece834e30a2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4f1d292aa8be965083ac635583abe99029fe0e860ab8a5541e4bd066aa11e115"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bc02db9cc813ae6c3b6a341b29f7d087f2761d42af8ede17db8c8e9cf43573cc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "642586bbb7e530312e6373ca267665f16ab89405f1f472db97d2d59d411ce4f3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "687d8e94d3f6e721eba4523cfd0ae2b87001e40bb6318d4bcf147c09e33e82e5"
    sha256 cellar: :any_skip_relocation, ventura:        "b668402323ed2397f6c070006acac5777cbe627f6d0fc95dabb4244ad6cc3d25"
    sha256 cellar: :any_skip_relocation, monterey:       "198f3c6e7b78c1405e3760682a765d9f42871f7240a18944f12549e85baaddc4"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "79251b070dde5fac445ec29d5e934da56d9655078d5d9844ecba5bf65e3b7cfc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cff144e7d7467eb9900fbe1423cc68743985582d06bec68cfbe63b0fdfa5e1f2"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
