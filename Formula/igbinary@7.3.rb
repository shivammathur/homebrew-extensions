# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "32e309d942e1c3a6a4039fb86a0f54a05d089d6553ccd0b38f2a223c78143d26"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cb52dd44403a9abf1f8b2a9ba3c8843b62b43e514ab7b0a5adeb80e1d598069a"
    sha256 cellar: :any_skip_relocation, monterey:       "0d038946da7b10e42bcc6a7a1d090f70ef22877a10028cc3bdbfc3450e82aa86"
    sha256 cellar: :any_skip_relocation, big_sur:        "45cadbf4d88097fec107827cc31a904e834e134ab6ca9121cba79c2cec170268"
    sha256 cellar: :any_skip_relocation, catalina:       "1c70fee7876d75f588a727193b614aa4669b3e96655971b03403c695623b1260"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31534b5f2fa09bb77ba2f80c53ae8e9a88ec76b2f482297968239104e4516fb9"
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
