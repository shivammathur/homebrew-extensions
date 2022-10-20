# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8bd568ca6aeb23b230ead5dca1d576ebc79a7e917ade509d878196f64f13903c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "03349787c24229dbc70a4009c93a263628b06a8c928ba9626db59e1d0ada24b8"
    sha256 cellar: :any_skip_relocation, monterey:       "55b962ed5baa7590032bbf6b0a77ccb1e354c24ee5adb20dd501bbe923d8b18f"
    sha256 cellar: :any_skip_relocation, big_sur:        "05d2c77b186743be9bfe5a10a43d17c2cd4f05d26af3546e5fbcce4242c0858f"
    sha256 cellar: :any_skip_relocation, catalina:       "39a0fbb298195328246e3e24ddb50510de53eca98fb259416c6b09c0c548ca88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "85faab5e2f9c8af2b6e68084609ba22f65c5166b38fb5893b2d335419c5869d0"
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
