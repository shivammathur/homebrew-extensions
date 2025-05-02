# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT80 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3275156f104c41ddd23945d59f029233b4dc5dc9a2b67b005e61e7a6c7c50fe2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "68fc41566104c63639260632fe70636962895e1cc6d97f54620837be74111ed6"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "92c83f798948a940fbc0eef765e855243251c80dc51155249f136db0ebeade2e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ad311c35111b5399d7b48351d263d422965f02e3ebf91df0d3a9df2a093716cf"
    sha256 cellar: :any_skip_relocation, ventura:        "1676a66ce06f9e3156f9658915e2252175b1606a625ad0fc48646d88bab9816b"
    sha256 cellar: :any_skip_relocation, monterey:       "075c794c2b178b157784151dfdc49624475b585f3e9fd566c90a81d26ae09dcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dbae4105e57042d6792b986d1ac99f06424622b86f7864e73582bb63a41cd2af"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
