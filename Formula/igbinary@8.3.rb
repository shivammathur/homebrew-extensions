# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c43e01670a3247baf402248a054332a282a17ace21ce6eab48816174c6b53df3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "88f68fb55e49911674358472fef7a63d72240244edd8ece854be783e2f380d7c"
    sha256 cellar: :any_skip_relocation, monterey:       "20a803241529331c844936bd10b1996e4ef8a2d579c4245eafca1deaa52ca7a4"
    sha256 cellar: :any_skip_relocation, big_sur:        "09ee9a43643b0e8db1511d977568708941a90c6f8c105e2a172067998b173858"
    sha256 cellar: :any_skip_relocation, catalina:       "534f7a6ac84872bea67b6374d3a795fb385feefad617da6a9275228057c62536"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5d28f60007bfc12642dea5cf320206dea2578dd71865269f2fa5d209e65bc48e"
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
