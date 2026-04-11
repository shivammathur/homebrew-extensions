# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT74 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.8.0.tgz"
  sha256 "19abac84376399017590e11c08297e6784e332ec7eb26665a55f8818333d73c0"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ad70325ece8f216e3784c9309bdb2a7b4946a10709b13bbd45c277c7230d536d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "12ac4eef7f049a50e4a3db91a53f61d915824c930472c5a42177bfca0ed39a7c"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c69669e2a63a107b03836691386d4254c07df9d271588d4cfd88eea41bd23b92"
    sha256 cellar: :any_skip_relocation, sonoma:        "454712a2b05ca5dedea2fe34ac7923c18ac4c20e7cd48a153a9ba6c78592ec6f"
    sha256 cellar: :any_skip_relocation, ventura:       "2a27914ee368e05b9646fbffe262bb29ed00fc53219d062f4afc99e9caefbe87"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a8bc8e213f3b43d2fcc499f3e3a476b7c6ef330949946700cdc1c8e628ca6c0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1296d465d05819d1381d05a417f1935298024f3b8c05a6a86806cf23a8e66e14"
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
