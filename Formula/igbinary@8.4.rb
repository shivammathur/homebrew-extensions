# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e0f42cbff0204916209b7fefee0ff01ef30785cd28289a5ec008f7daf66a83a7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d8085359e68bade6f120ccf3ccd1c710205db7f3b84f151e4f892f6237355a7d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9b662d1900f2e889504316868ab7244e36de0024b44c3b57d2d34da581350867"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dc991eb5a46f0d9a3e2ab61c1714a9e95864b95c33bfd1d8904f1937bb5e0ba3"
    sha256 cellar: :any_skip_relocation, ventura:        "8030635fcca2ae63d7c5bfc090789c1e1db8ad9db5202d68704571df21e508c0"
    sha256 cellar: :any_skip_relocation, monterey:       "4e9d44a109273332498121c505855e86bdb5cfd3a6b2dd9290e5968a477ef2c2"
    sha256 cellar: :any_skip_relocation, big_sur:        "72b1895a2e78375e86c8a01641f7d905c1f47498f7ed6b62a76bfc033036b096"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "688c811425435b5ff868c4fdd5c71bf801b958195f82fbe8c26c6a0b41ea3692"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
