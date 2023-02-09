# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.13.tar.gz"
  sha256 "4400ecefafe0901c2ead0e1770b0d4041151e0c51bcb27c4a6c30becb1acb7da"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "258e446ea02576c1193b1df1e1d72defc6172c808ac344916231f36e6b913fd9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "90e9e68bb857b332deabb1fe09afabffcff23450b1232c33d337368ccb55945e"
    sha256 cellar: :any_skip_relocation, monterey:       "d262d0e040be725a15123366fb0b08fa025554d97357b5d27eb7e90af4a582e7"
    sha256 cellar: :any_skip_relocation, big_sur:        "78022083dc078dd079984a8c49fdb480d517db20d415e41127fb81854592b9da"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4ab6ef0097917a239bcedbc06069e2173d291d95381bc543c07d575dcfa69294"
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
