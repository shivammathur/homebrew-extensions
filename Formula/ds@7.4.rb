# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT74 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e485d3e323663bb5e2a5cb51f07228383e4742b9c41f0b5b152650bb1a89ba3c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "332ec62472aac204793745bfce285c3ba17db8ac1abec475525ac9d036a685fd"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "42fc9dc8ae8ba49626649840327df40b95f12129c06cc2515b11cfb3794c1731"
    sha256 cellar: :any_skip_relocation, ventura:        "1d3eb78c45b9e97dbe43496e9dd89cf3ff4f437ea78a881880210665ec68fe21"
    sha256 cellar: :any_skip_relocation, monterey:       "299741c2a088229853038c9675d415689da9a95a38d57b9fb236f1d273ef42e5"
    sha256 cellar: :any_skip_relocation, big_sur:        "b5394d77df8d8f6f0c36324b6351eb8ab447dca11216303e58c850082e19bb86"
    sha256 cellar: :any_skip_relocation, catalina:       "2876189ca00ca7c3994396958e8663e33271586f8e3d0c0a9207b89b5dbd285e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1824028434c2a55d44ce93986e07711873ba1c201ce5a95adc1666856c7e96b4"
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
